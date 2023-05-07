# Makefile from coctb template

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += butterfly.v
VERILOG_SOURCES += hex_decoder.v
# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = butterfly

# MODULE is the basename of the Python test file
MODULE = butterfly_tb

# Verbosity of logging
export COCOTB_LOG_LEVEL=INFO

# Use COMPILE_ARGS to send module parameters or defines to vvp
COMPILE_ARGS=-DCOCOTB_FAST_DEBOUNCE
# uncomment this to dump waveforms
COMPILE_ARGS+=-DCOCOTB_SIM_WAVEFORMS
# Uncomment this to use an extra register for storing Re(a)
#COMPILE_ARGS+=-DALTERNATE_OUTPUTS

# These numbers control how many iterations of constrained random sim occur
# i.e you get (N_COEFFICIENT_PAIRS * N_BUTTERFLIES) butterfly multiplications
# If this number is large, it is recommended not to dump waveforms!
export N_COEFFICIENT_PAIRS = 10
export N_BUTTERFLIES = 10

# Constrain the random inputs to only those that will produce results within the range of 8-bit signed ints
export VALID_INPUTS_ONLY = 1

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim