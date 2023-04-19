// Testbench for the combined add_sum multiplier

module mult_add_tb();

logic clock, input_a_reg_en, input_b_reg_en, output_reg_en, subtract, rst;

wire [32:0] result;

logic [15:0] data_a_0, data_a_1, data_b_0, data_b_1;

// Clock gen
always begin
  clock = 1'b0;
  #5;
  clock = 1'b1;
  #5;  
end

// Dump waveforms
initial begin
   $dumpfile("mult_add_tb.vcd");
   $dumpvars(0,mult_add_tb);
end

initial begin
  subtract       = 1'b0;
  input_a_reg_en = 1'b1;
  input_b_reg_en = 1'b1;
  output_reg_en  = 1'b1;
  rst            = 1'b0;
  
  data_b_0 = 16'd1;
  data_b_1 = 16'd1;
  data_a_0 = 16'd5;
  data_a_1 = 16'd10;

  # 10;

  data_b_0 = 16'd1;
  data_b_1 = 16'd2;
  data_a_0 = 16'd5;
  data_a_1 = 16'd10;

  #20 ;

  subtract = 1'b1;

  #10 ;

  input_b_reg_en = 1'b0;
  data_b_0 = 16'd0;
  data_b_1 = 16'd0;

  #10;

  data_a_0 = 16'd0;

  #20;

  rst = 1'b1;

  #100;
  $finish();

end

// Result = dataa_0*datab_0 +/- dataa_1*datab_1
mult_add dut(
    .result(result),   //   result.result
    .dataa_0(data_a_0),  //  dataa_0.dataa_0
    .dataa_1(data_a_1),  //  dataa_1.dataa_1
    .datab_0(data_b_0),  //  datab_0.datab_0
    .datab_1(data_b_1),  //  datab_1.datab_1
    .addnsub1(subtract), // addnsub1.addnsub1
    .clock0(clock),   //   clock0.clock0
    .clock1(clock),   //   clock1.clock1
    .clock2(clock),   //   clock2.clock2
    .ena0(input_a_reg_en),     //     ena0.ena0
    .ena1(input_b_reg_en),     //     ena1.ena1
    .ena2(output_reg_en),      //     ena2.ena2
    .sclr0(rst)
  );
  
endmodule