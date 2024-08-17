
## Uni of Southampton ELEC6233 "Butterfly" complex multiplier

Source code for a complex butterfly multiplier targeting the Altera De1-SoC FPGA devboard, implemented as coursework for the Univerisity of Southampton ELEC6233 digital systems synthesis module.

The Verilog `butterfly_datapath_tb.v` testbench tests the core of the design, generating VCD only (was used for development). It can be run with the `simulate_icarus.bat` script with icarus verilog installed.

The CocoTB `butterfly_tb.py` tests the top-level of the design, including inputting coefficients using the switches, simulating switch bounce to test debouncing logic, and constrained random testing of many operations. This can be run with cocotb and iverilog installed by running `make`.
