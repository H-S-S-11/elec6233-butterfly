module butterfly(
  input wire CLOCK_50,
  input wire [9:0] SW,
  output wire [7:0] LEDR
);

wire reset;
// SW[9] is an active low reset, datapath has active high
assign reset = ! SW[9];

// Control signals to datapath
wire load_output_reg, load_coeff, load_b, load_mult;
wire multiply, subtract, mult_out_select, fbr_input;

assign load_output_reg = 1'b1;
assign multiply = 1'b1;
assign load_mult = 1'b1;
assign load_b = 1'b1;
assign fbr_input = 1'b1;


butterfly_datapath datapath(
  .clk(CLOCK_50), .reset(reset),
  .load_coeff(load_coeff),            // loads re(w) pipeline reg and coeff regs
  .load_b(load_b),                    // loads b pipeline regs
  .load_mult(load_mult),              // Loads DSP input mult regs and swaps b
  .multiply(multiply),                // Enables DSP output reg and Re(mout) reg   
  .load_output_reg(load_output_reg),  // Enables LED output and feedback registers
  .subtract(subtract),                // Controls the two add/sub blocks
  .mult_out_select(mult_out_select),  // Mux select for LED and feedback regs from multiplier output (opposite polarities)
  .fbr_input(fbr_input),              // Makes output feedback reg load the data input
  .data_in(SW[7:0]),    // Leftmost switches are MSB
  .data_out(LEDR[7:0])   // Leftmost LEDS are MSB
);
  
endmodule


module butterfly_datapath(
  input   wire        clk, reset,
  input   wire        load_coeff,      // loads re(w) pipeline reg and coeff regs
  input   wire        load_b,          // loads b pipeline regs
  input   wire        load_mult,       // Loads DSP input mult regs and swaps b
  input   wire        multiply,        // Enables DSP output reg and Re(mout) reg   
  input   wire        load_output_reg, // Enables LED output and feedback registers
  input   wire        subtract,        // Controls the two add/sub blocks
  input   wire        mult_out_select, // Mux select for LED and feedback regs from multiplier output (opposite polarities)
  input   wire        fbr_input,       // Makes output feedback reg load the data input
  input   wire [7:0]  data_in,
  output  wire [7:0]  data_out
);

// Re(w) pipeline reg
reg [7:0] re_w_pipeline;
always @(posedge clk) begin
  if (reset) begin
    re_w_pipeline <= 8'd0;
  end else begin
    if (load_coeff) begin
      re_w_pipeline <= data_in;
    end
  end  
end

// b pipeline regs
reg [7:0] b_pipeline_0, b_pipeline_1;
always @(posedge clk) begin
  if (reset) begin
    b_pipeline_0 <= 8'd0;
    b_pipeline_1 <= 8'd0;
  end else begin
    if (load_b) begin
      b_pipeline_0 <= b_pipeline_1;
      b_pipeline_1 <= load_mult ? b_pipeline_0 : data_in;
    end
  end
end

// Re (mout) reg
wire [32:0] result;
wire [8:0]  mult_out;
reg  [8:0]  re_mult_out;
// Slice here for truncation determined by waveform inspection, keeping one bit below the d.p
assign mult_out = result[22:14];
always @(posedge clk) begin
  if (reset) begin
    re_mult_out <= 8'd0;
  end else begin
    if (multiply) begin
      re_mult_out <= mult_out;
    end
  end
end

// fbr and output reg
assign data_out = led[8:1];
reg  [8:0] led, feedback;
wire [8:0] fbr_sub_in, led_add_in;
assign fbr_sub_in = mult_out_select ? re_mult_out : mult_out;
assign led_add_in = mult_out_select ? mult_out : re_mult_out;
always @(posedge clk) begin
  if (reset) begin
    led <= 9'd0;
    feedback <= 9'd0;
  end else begin
    if (load_output_reg) begin
      feedback  <= fbr_input ? {data_in, 1'b0} : led - fbr_sub_in;
      if (subtract) begin
        led <= feedback - led_add_in;
      end else begin
        led <= feedback + led_add_in;
      end
    end
  end
end

// Result = dataa_0*datab_0 +/- dataa_1*datab_1
mult_add multiplier(
  .result(result),          //  result.result
  .dataa_0({ {8{re_w_pipeline[7] }}, re_w_pipeline}),  // Re(w) reg -sign extended to 16 bits (chipverify.com)
  .dataa_1({ {8{data_in[7]       }}, data_in      }),  // Im(w) reg
  .datab_0({ b_pipeline_0          , 8'd0         }),  // mult0 -left shifted for fixed point
  .datab_1({ b_pipeline_1          , 8'd0         }),  // mult1
  .addnsub1(subtract),  // addnsub1, use_subnadd=1
  .ena0(load_coeff),    // load w
  .ena1(load_mult),     // load mult 0, 1
  .ena2(multiply) ,     // output reg enable
  .sclr0(reset),        // Sync active high reset
  .clock0(clk), .clock1(clk), .clock2(clk) // common clk
);

endmodule