# using template from cocotb examples

import os
import random
import sys
from pathlib import Path

import cocotb
from cocotb.clock import Clock
#from cocotb.runner import get_runner
from cocotb.triggers import FallingEdge, Timer


async def reset(dut, duration_ms, active_low=True):
  dut.SW_nResetSync._log.debug("Reset")
  dut.SW_nResetSync.value = 1-int(active_low)
  await Timer(duration_ms, units="ms")
  dut.SW_nResetSync.value = int(active_low)
  dut.SW_nResetSync._log.debug("Reset complete")

@cocotb.test()
async def butterfly_test(dut):
  # Debounce module has a macro to speed up 1000x in simulation, so slow down clock
  clock = Clock(dut.CLOCK_50, 20, units="us")
  cocotb.start_soon(clock.start())  # Start the clock

  await FallingEdge(dut.CLOCK_50)
  await reset(dut, 20)
  await Timer(10, units="ms")


  
# Python runners are experimental feature
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