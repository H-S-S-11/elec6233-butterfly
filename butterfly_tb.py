# using template from cocotb examples

import os
import random
import sys
from pathlib import Path
import math

import cocotb
from cocotb.clock import Clock
#from cocotb.runner import get_runner
from cocotb.triggers import FallingEdge, Timer


async def reset(dut, duration_ms, active_low=True):
  dut.SW_nResetSync._log.info("Reset started")
  dut.SW_nResetSync.value = 1-int(active_low)
  await Timer(duration_ms, units="ms")
  dut.SW_nResetSync.value = int(active_low)
  dut.SW_nResetSync._log.info("Reset complete")

async def bouncy_switch(signal, value, max_bounce_length_us=2000, max_n_bounces=5):
  signal._log.debug("Setting to %d with bounces", value)
  for i in range(random.randint(1,max_n_bounces)):
    signal.value = value
    await Timer(random.randint(int(max_bounce_length_us/1000),max_bounce_length_us), units="us")
    signal.value = 1 - value
    await Timer(random.randint(int(max_bounce_length_us/1000),max_bounce_length_us), units="us")
  signal.value = value

async def load_data_in(dut, value, switch_high_ms=30, switch_low_ms=20, keep_Ready_high=False):
  dut._log.debug("Loading data in: %d", value)
  dut.SW.value = value
  await bouncy_switch(dut.SW_ReadyIn, 1)
  await Timer(switch_high_ms, units="ms")
  if (not keep_Ready_high):
    await bouncy_switch(dut.SW_ReadyIn, 0)
    await Timer(switch_low_ms, units="ms")

async def load_coefficients(dut, re_w, im_w):
  dut._log.info("Setting coefficients to Re(w)=%f, im_w=%f", re_w, im_w)
  if (abs(re_w) > 1) or (abs(im_w) > 1):
    raise ValueError("Coeffiecient must be between -1 and (1- 2^(-8))")
  dut.SW_ReadyIn.value = 0
  await reset(dut, 50)  
  await Timer(20, units="ms")
  # Convert to fixed point
  await load_data_in(dut, math.floor(re_w*(2**7)) )
  await load_data_in(dut, math.floor(im_w*(2**7)) )
  await Timer(30, units="ms")

async def butterfly_mult(dut, re_w, im_w, re_b, im_b, re_a, im_a):
  dut._log.info("Caculating: (%d+%di) + (%f+%fi)*(%d+%di), (%d+%di) - (%f+%fi)*(%d+%di)", \
    re_a, im_a, re_w, im_w, re_b, im_b, re_a, im_a, re_w, im_w, re_b, im_b)
  await Timer(30, units="ms")
  for data in [re_b, im_b, re_a]:
    await load_data_in(dut, data)
  await load_data_in(dut, im_a, keep_Ready_high=True)
  # Wait 20ms for ReadyIn to debounce so the data gets loaded in
  await Timer(20, units="ms")
  yz = {}
  yz['Re(y)'] = dut.LEDR.value.signed_integer
  for result in ['Im(y)', 'Re(z)', 'Im(z)']:
    await bouncy_switch(dut.SW_ReadyIn, 0)
    await Timer(20, units="ms")
    await bouncy_switch(dut.SW_ReadyIn, 1)
    await Timer(20, units="ms")
    yz[result] = dut.LEDR.value.signed_integer
  dut._log.info(f"Result: {yz}")
  expected_results = {
    'Re(y)' : math.floor( re_a + (re_b*re_w - im_b*im_w) ),
    'Im(y)' : math.floor( im_a + (im_b*re_w + re_b*im_w) ),
    'Re(z)' : math.floor( re_a - (re_b*re_w - im_b*im_w) ),
    'Im(z)' : math.floor( im_a - (im_b*re_w + re_b*im_w) ),
  }
  dut._log.info(f"Expected Result: {expected_results}")
  assert (yz==expected_results), f"Results {yz} differ from expected {expected_results}" #f"Expected {result}={expected_results[result]} but got {yz[result]}")

  await bouncy_switch(dut.SW_ReadyIn, 0)
  await Timer(10, units="ms")

@cocotb.test()
async def butterfly_test(dut):
  # Debounce module has a macro to speed up 1000x in simulation, so slow down clock
  clock = Clock(dut.CLOCK_50, 20, units="us")
  cocotb.start_soon(clock.start())  # Start the clock

  await FallingEdge(dut.CLOCK_50)
  await reset(dut, 20)
  await Timer(10, units="ms")

  await load_coefficients(dut, 0.75, -0.25)
  await butterfly_mult(dut, 0.75, -0.25, 6, 20, 10, 12)



  

# Python runners are experimental feature, not using them
#def test_butterfly_runner():
#
#    proj_path = Path(__file__).resolve().parent
#
#    runner = get_runner("icarus")
#    runner.build( runner,
#        verilog_sources=[proj_path / "butterfly.v"],
#        always=True,
#    )
#
#
#    runner.test(hdl_toplevel="butterfly", test_module="test_butterfly,")
#    
#    
#if __name__ == "__main__":
#    test_butterfly_runner()