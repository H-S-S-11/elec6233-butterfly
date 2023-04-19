
module butterfly_datapath_tb ();

reg clk, reset, load_coeff, load_b, load_mult, multiply;
reg load_output_reg, subtract, mult_out_select, fbr_input;

reg ready_in;

reg  [7:0] data_in;
wire [7:0] data_out;

// https://fpgatutorial.com/verilog-function-and-task/
// https://www.chipverify.com/verilog/verilog-task
task load_w(input [7:0] re, input [7:0] im);
  begin
    // One ReadyIn cycle
    #50;
    // Input Re (w)
    data_in = re;
    load_coeff = 1'b1;
    #10;
    load_coeff = 1'b0;
    #90;
    // Input Im (w)
    data_in = im;
    load_coeff = 1'b1;
    #10;
    load_coeff = 1'b0;
    #40;
end  
endtask

// Clock gen
always begin
  clk = 1'b0;
  #5;
  clk = 1'b1;
  #5;  
end

always begin
  ready_in = 1'b0;
  #50;
  ready_in = 1'b1;
  #50;  
end

initial begin
  reset = 1'b1;
  load_coeff  = 1'b0;
  load_b      = 1'b0;
  load_mult   = 1'b0;
  data_in = 8'd0;
  subtract = 1'b0;
  multiply = 1'b0;
  load_output_reg = 1'b0;
  fbr_input = 1'b0;
  mult_out_select = 1'b0;

  #10;
  reset = 1'b0;

  // Load Re(w) = 0.75, Im(w) = -0.25
  load_w(8'b01100000, 8'b11100000);

  #50;
  // Input Re (b) = 6
  data_in = 8'd6;
  load_b = 1'b1;
  #10;
  load_b = 1'b0;
  #40;

  #50;
  // Input Im (b) = 20
  data_in = 8'd20;
  load_b = 1'b1;
  #10;
  load_b = 1'b0;
  #40;
  // Load multiplier input regs and swap b
  load_mult = 1'b1;
  load_b    = 1'b1;
  #10;
  load_mult = 1'b0;
  load_b    = 1'b0;

  #40;
  // load Re(a)=10
  // Perform first multiply Re(b)Re(w) - Im(b)Im(w) = 9.5
  data_in   = 8'd10;
  subtract  = 1'b1;
  multiply  = 1'b1;
  load_mult = 1'b1;
  load_output_reg = 1'b1;
  fbr_input = 1'b1;
  #10;
  subtract  = 1'b0;
  multiply  = 1'b0;
  load_mult = 1'b0;
  load_output_reg = 1'b0;
  fbr_input = 1'b0;
  #40;
  // Perform second multiply Re(w)Im(b) + Im(w)Re(b) = 13.5
  multiply  = 1'b1;
  #10;
  multiply  = 1'b0;

  #40;
  // load Im(a) = 12
  // Disp Re y = Re(a) + Re(mout) = 19.5
  load_output_reg = 1'b1;
  fbr_input = 1'b1;
  data_in   = 8'd12;
  // mult_out_select = 0
  #10;
  load_output_reg = 1'b0;
  fbr_input       = 1'b0;

  #50;
  // Disp Im y = Im(a) + Im(mout) = 25.5
  load_output_reg = 1'b1;
  mult_out_select = 1'b1;
  #10;
  load_output_reg = 1'b0;
  mult_out_select = 1'b0;

  #50;
  // Disp Re z = Re(a) - Re(mout) = 0.5
  load_output_reg = 1'b1;
  mult_out_select = 1'b0;
  subtract        = 1'b1;
  #10;
  load_output_reg = 1'b0;
  mult_out_select = 1'b0;
  subtract        = 1'b0;

  #50;
  // Disp Im z = Im(a) - Im(mout) = -1.5
  load_output_reg = 1'b1;
  mult_out_select = 1'b1;
  subtract        = 1'b1;
  #10;
  load_output_reg = 1'b0;
  mult_out_select = 1'b0;
  subtract        = 1'b0;


  #1000;
  $finish();

end


butterfly_datapath dut(
  .clk(clk), .reset(reset),
  .load_coeff(load_coeff),            // loads re(w) pipeline reg and coeff regs
  .load_b(load_b),                    // loads b pipeline regs
  .load_mult(load_mult),              // Loads DSP input mult regs and swaps b
  .multiply(multiply),                // Enables DSP output reg and Re(mout) reg   
  .load_output_reg(load_output_reg),  // Enables LED output and feedback registers
  .subtract(subtract),                // Controls the two add/sub blocks
  .mult_out_select(mult_out_select),  // Mux select for LED and feedback regs from multiplier output (opposite polarities)
  .fbr_input(fbr_input),              // Makes output feedback reg load the data input
  .data_in(data_in),
  .data_out(data_out)
);
  
// Dump waveforms
initial begin
   $dumpfile("butterfly_datapath_tb.vcd");
   $dumpvars(0,butterfly_datapath_tb);
end

endmodule