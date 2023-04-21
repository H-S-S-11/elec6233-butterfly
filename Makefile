# Makefile from coctb template

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += butterfly.v
VERILOG_SOURCES += quartus_ip/mult_add.v
VERILOG_SOURCES += quartus_ip/mult_add/mult_add_0002.v
VERILOG_SOURCES += C:/intelFPGA_lite/20.1/quartus/libraries/megafunctions/altera_mult_add_rtl.v
# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = butterfly

# MODULE is the basename of the Python test file
MODULE = butterfly_tb

# Use COMPILE_ARGS to send module parameters or defines to vvp
# Eg uncomment this to dump waveforms
COMPILE_ARGS=-DCOCOTB_SIM_WAVEFORMS

# Verbosity of logging
export COCOTB_LOG_LEVEL=INFO

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim