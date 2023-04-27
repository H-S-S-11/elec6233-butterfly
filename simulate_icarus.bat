Rem If altera_mult_add isn't found the module declaration needs to be copied from C:\intelFPGA_lite\20.1\quartus\eda\sim_lib\altera_lnsim.v into the IP file

Rem iverilog -o mult_add_tb.vvp mult_add_tb.v ../quartus_ip/mult_add.v ../quartus_ip/mult_add/mult_add_0002.v C:\intelFPGA_lite\20.1\quartus\libraries\megafunctions\altera_mult_add_rtl.v
Rem vvp mult_add_tb.vvp

Rem Source for g2012 switch for enum support https://electronics.stackexchange.com/questions/530123/viewing-verilog-enums-in-iverilog-gtkwave
iverilog -g2012 -o butterfly_datapath_tb.vvp butterfly_datapath_tb.v butterfly.v hex_decoder.v ../quartus_ip/mult_add.v ../quartus_ip/mult_add/mult_add_0002.v C:\intelFPGA_lite\20.1\quartus\libraries\megafunctions\altera_mult_add_rtl.v

vvp butterfly_datapath_tb.vvp
