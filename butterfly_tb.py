# using template from cocotb examples

import os
import random
import sys
from pathlib import Path
import math

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, Timer

# A function to calculate the full-precision butterfly outputs y and z
def expected_result(re_w, im_w, re_b, im_b, re_a, im_a):
  expected = {
    'Re(y)' : re_a + (re_b*re_w - im_b*im_w),
    'Im(y)' : im_a + (im_b*re_w + re_b*im_w),
    'Re(z)' : re_a - (re_b*re_w - im_b*im_w),
    'Im(z)' : im_a - (im_b*re_w + re_b*im_w),
  }
  return expected

# Equivalent to a Verilog task that can be called in the main testbench to reset the DUT
async def reset(dut, duration_ms, active_low=True):
  dut.SW_nResetSync._log.info("Reset started")
  dut.SW_nResetSync.value = 1-int(active_low)
  await Timer(duration_ms, units="ms")
  dut.SW_nResetSync.value = int(active_low)
  dut.SW_nResetSync._log.info("Reset complete")

# A task for toggling a signal with random bounces
async def bouncy_switch(signal, value, max_bounce_length_us=2000, max_n_bounces=5):
  signal._log.debug("Setting to %d with bounces", value)
  # Bounce a random number of times
  for i in range(random.randint(1,max_n_bounces)):
    # Set the signal to the new value for a (constrained) random length of time
    signal.value = value
    await Timer(random.randint(int(max_bounce_length_us/1000),max_bounce_length_us), units="us")
    # Bounce back to the old signal for a constrained random length of time
    signal.value = 1 - value
    await Timer(random.randint(int(max_bounce_length_us/1000),max_bounce_length_us), units="us")
  # Set the signal to it's final value
  signal.value = value

# A task for loading in one of the data inputs
async def load_data_in(dut, value, switch_high_ms=30, switch_low_ms=20, keep_Ready_high=False):
  dut._log.debug("Loading data in: %d", value)
  # Set the switches to the desired value
  dut.SW.value = value
  # set ReadyIn high using the bounce task
  await bouncy_switch(dut.SW_ReadyIn, 1)
  # Leave the switch high for specified length of time
  await Timer(switch_high_ms, units="ms")
  # This is useful when we are just consecutively loading in data,
  # and aren't doing anything before the next load_data_in function
  if (not keep_Ready_high):
    await bouncy_switch(dut.SW_ReadyIn, 0)
    await Timer(switch_low_ms, units="ms")

# Task to load w into the DUT
async def load_coefficients(dut, re_w, im_w):
  dut._log.info("Setting coefficients to Re(w)=%f, im_w=%f", re_w, im_w)
  # Check for valid coefficent values
  if (abs(re_w) > 1) or (abs(im_w) > 1):
    raise ValueError("Coeffiecient must be between -1 and (1- 2^(-8))")
  # First reset the DUT
  dut.SW_ReadyIn.value = 0
  await Timer(50, units="ms")
  await reset(dut, 50)  
  await Timer(20, units="ms")
  # Convert to fixed point and load the coefficients
  await load_data_in(dut, math.floor(re_w*(2**7)) )
  await load_data_in(dut, math.floor(im_w*(2**7)) )
  await Timer(30, units="ms")

# Runs the butterfly multiplication (the DUT already has coefficients loaded in)
async def butterfly_mult(dut, re_w, im_w, re_b, im_b, re_a, im_a):
  dut._log.info("Calculating: (%d+%di) + (%f+%fi)*(%d+%di), (%d+%di) - (%f+%fi)*(%d+%di)", \
    re_a, im_a, re_w, im_w, re_b, im_b, re_a, im_a, re_w, im_w, re_b, im_b)
  await Timer(30, units="ms")
  # Input b and Re(a)
  for data in [re_b, im_b, re_a]:
    await load_data_in(dut, data)
  # Load in Im(a) but leave ReadyIn high so we can read the outputs
  await load_data_in(dut, im_a, keep_Ready_high=True)
  # Wait 20ms for ReadyIn to debounce so Im(a) gets loaded in and the calculation is performed
  await Timer(20, units="ms")
  # Make a dict to hold the results and read out the first result
  yz = {}
  yz['Re(y)'] = dut.LEDR.value.signed_integer
  # Read out the remaining results and print to the console
  for result in ['Im(y)', 'Re(z)', 'Im(z)']:
    await bouncy_switch(dut.SW_ReadyIn, 0)
    await Timer(20, units="ms")
    await bouncy_switch(dut.SW_ReadyIn, 1)
    await Timer(20, units="ms")
    yz[result] = dut.LEDR.value.signed_integer
  await bouncy_switch(dut.SW_ReadyIn, 0)
  await Timer(10, units="ms")
  dut._log.info(f"DUT      Result: {yz}")
  
  # Calculate the expected result
  float_results = expected_result(re_w, im_w, re_b, im_b, re_a, im_a)
  # Expected results are what we would get if the outputs were simply truncated (rounded down)
  expected_results = {}
  for key, value in float_results.items():
    expected_results[key] = math.floor(value)
  dut._log.info(f"Float    Result: {float_results}")
  dut._log.info(f"Expected Result: {expected_results}")
  # Check if any of the expected results are outside 8-bit signed range
  for calc, expected in expected_results.items():
    if (expected > 127) or (expected < -128):
      dut._log.warning(f"Expected value of {calc} ({expected}) is not a valid 8-bit signed integer, ignoring this calculation")
      return
  # Otherwise check results are equal
  if yz != expected_results:
    dut._log.warning(f"Results {yz} differ from expected {expected_results}")
    # Only a warning because this could mean we are rounding up.
    # If this is the case, ensure that the difference to the full precision result is less than 0.5LSB
    for key, value in float_results.items():
      diff = yz[key] - value
      dut._log.warning(f"{key} differs by {diff} from the full-precision result ({value})")
      assert ( (diff < 0.5) & (diff > -1)), f"Difference ({diff}) is outside allowed range (-1 to +0.5)"
    
# Function to randomly generate values of a and b based on w
def generate_inputs(dut, re_w, im_w, validate=False):
  re_a = random.randint(-128, 127)
  im_a = random.randint(-128, 127)
  re_b = random.randint(-128, 127)
  im_b = random.randint(-128, 127)
  # Optionally, only allow values of a and b that generate y and z values
  # that are within the 8-bit signed integer
  if validate:
    expected = expected_result(re_w, im_w, re_b, im_b, re_a, im_a)
    for value in expected.values():
      if (value > 127) or (value < -128):
        # Outside allowed range, retry recursively
        try:
          return generate_inputs(dut, re_w, im_w, validate=True)
        except RecursionError:
          # Exceeded the max recursion depth, just use a safe combination and log a warning
          dut._log.warning("RecursionError while trying to generate valid inputs. Using 1, 1, 1, 1")
          return 1, 1, 1, 1
  return re_b, im_b, re_a, im_a

# Task for running butterfly multiplications with random inputs
async def random_butterfly_mult(dut, re_w, im_w, validate_inputs=False):
  re_b, im_b, re_a, im_a = generate_inputs(dut, re_w, im_w, validate=validate_inputs)
  await butterfly_mult(dut, re_w, im_w, re_b, im_b, re_a, im_a)

# Main testbench
@cocotb.test()
async def butterfly_test(dut):
  # Create a clock. The dbounce module has a macro to speed up 1000x in simulation
  # (otherwise sim takes far too long) so slow the clock down by the same factor
  # This means delays and switch bounce time is equivalent to real-world timing
  clock = Clock(dut.CLOCK_50, 20, units="us")
  cocotb.start_soon(clock.start())  # Start the clock

  # Reset to start
  await FallingEdge(dut.CLOCK_50)
  await reset(dut, 20)
  await Timer(10, units="ms")

  # Basic test case used in Verilog testbench of core design
  # re_w, im_w
  await load_coefficients(dut, 0.75, -0.25)
  # re_w, im_w, re_b, im_b, re_a, im_b
  await butterfly_mult(dut, 0.75, -0.25, 6, 20, 10, 12)
  # Example with larger numbers that cause overflow
  await butterfly_mult(dut, 0.75, -0.25, 100, -80, 75, 120)

  # These examples (generated from constrained random stimuli) hit corner cases in terms of rounding of results
  # Feedback reg causes negative results to be rounded to the nearest integer (rather than floored)
  await load_coefficients(dut, 0.031250, 0.718750)
  await butterfly_mult(dut, 0.031250, 0.718750, -96, -103, 31, 18)
  await load_coefficients(dut, -0.3671875, 0.1328125)
  await butterfly_mult(dut, -0.3671875, 0.1328125, -47, -70, -96, 1)

  # These random cases made an earlier version of the design fail, but not when running on their own
  # This problem was fixed by making sure all control signals are cleared by default in the controller state machine
  await load_coefficients(dut, 0.2890625, -0.1796875)
  await butterfly_mult(dut, 0.2890625, -0.1796875, 36, -99, -27, 53)
  await load_coefficients(dut, -0.6171875, -0.2890625)
  await butterfly_mult(dut,  -0.6171875, -0.2890625, -85, 92, 9, 10)

  # This lets us define in the makefile how many times these loops run (default 1)
  n_coefficients = int( os.getenv("N_COEFFICIENT_PAIRS", 1))
  n_butterflies  = int( os.getenv("N_BUTTERFLIES", 1))
  # Can also choose in the Makefile whether to only allow calculations that won't overflow (default 0)
  validate_inputs= bool(int(os.getenv("N_BUTTERFLIES", 0)))

  for n_coeff in range(0, n_coefficients):
    # Generate a random pair of coefficients and load into the DUT
    re_w = random.randint(-128, 127) / (2**7)
    im_w = random.randint(-128, 127) / (2**7)
    await load_coefficients(dut, re_w, im_w)
    # Perform specified number of butterfly calcs for each coefficient pair,
    # with or withour validated a and b inputs
    for n_butterfly in range(0, n_butterflies):
      await random_butterfly_mult(dut, re_w, im_w, validate_inputs=validate_inputs)
      
  await Timer(20, units="ms")
