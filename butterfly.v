`default_nettype none

module butterfly(
  input wire CLOCK_50,
  input wire SW_nResetSync,
  input wire SW_ReadyIn,
  input wire [7:0] SW,
  output wire [7:0] LEDR,
  output wire [6:0] HEX5, HEX4, HEX1, HEX0
);

reg reset, mid_sync_reset;
reg [1:0] SW_ReadyIn_sync;
// SW[9] is an active low reset, datapath has active high
// Sync the reset and the ReadyIn signal
always @(posedge CLOCK_50) begin
  mid_sync_reset <= ! SW_nResetSync;
  reset <= mid_sync_reset;
  SW_ReadyIn_sync <= {SW_ReadyIn, SW_ReadyIn_sync[1]};
end


// Control signals to datapath
wire load_output_reg, load_coeff, load_b, load_mult;
wire multiply, subtract, mult_out_select, fbr_input;

// SW_ReadyIn can bounce. In order to debounce, require the switch input is high for
// 10ms (~500k cycles @ 50MHz) before toggling the signal to the module
reg [19:0] debounce_count;
wire ready_in;
assign ready_in = debounce_count[19];

always @(posedge CLOCK_50) begin
    if (reset) begin
      debounce_count <= '0;
    end else begin
      if (SW_ReadyIn_sync[0] ) begin
        if (!ready_in) debounce_count <= debounce_count + 20'd1;
        // Speed up debouncing by a factor of 1000 in simulation
        `ifdef COCOTB_SIM_WAVEFORMS
        if (!ready_in) debounce_count <= debounce_count + 1024;
        `endif
      end else begin
        debounce_count <= '0;
      end
    end
end


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
  .data_in(SW[7:0]),                  // Leftmost switches are MSB
  .data_out(LEDR[7:0])                // Leftmost LEDS are MSB
);

butterfly_controller control_dut(
  .clk(CLOCK_50), .reset(reset),
  .ReadyIn        (ready_in),
  .load_coeff     (load_coeff),     
  .load_b         (load_b),         
  .load_mult      (load_mult),      
  .multiply       (multiply),       
  .load_output_reg(load_output_reg),
  .subtract       (subtract),       
  .mult_out_select(mult_out_select),
  .fbr_input      (fbr_input)
);

// Hex decoders to make entry and result checking easier
hex_decoder hex0(
  .value(SW[3:0]),
  .segments(HEX0)
);

hex_decoder hex1(
  .value(SW[7:4]),
  .segments(HEX1)
);

hex_decoder hex4(
  .value(LEDR[3:0]),
  .segments(HEX4)
);

hex_decoder hex5(
  .value(LEDR[7:4]),
  .segments(HEX5)
);

// For simulating with CocoTB
`ifdef COCOTB_SIM_WAVEFORMS
initial begin
    $dumpfile("butterfly.vcd");
    $dumpvars(0, butterfly);
end
`endif
  
endmodule

module butterfly_controller(
  input wire clk, reset, ReadyIn,
  output reg load_coeff, load_b, load_mult,
  output reg multiply, load_output_reg, subtract,
  output reg mult_out_select, fbr_input
);

typedef enum reg [3:0] {
  s_reset,
  s_read_re_w, s_read_im_w,
  s_read_re_b, s_read_im_b, s_load_mult,
  s_read_re_a, s_mult2, s_read_im_a,
  s_disp_im_y, s_disp_re_z, s_disp_im_z} state_t;
state_t state;

reg last_ReadyIn;
wire ReadyIn_rise, ReadyIn_fall;
assign ReadyIn_rise = (~last_ReadyIn) &   ReadyIn ;
assign ReadyIn_fall =   last_ReadyIn  & (~ReadyIn);

always @(posedge clk) begin
  if(reset) begin
    state <= s_read_re_w;
    last_ReadyIn <= 1'b0;

    load_coeff      <= 1'b0;
    load_b          <= 1'b0;
    load_mult       <= 1'b0;
    load_output_reg <= 1'b0;
    multiply        <= 1'b0;
    subtract        <= 1'b0;
    mult_out_select <= 1'b0;
    fbr_input       <= 1'b0;
  end else  begin
    last_ReadyIn <= ReadyIn;
    // Register enables must pulse
    load_coeff      <= 1'b0;
    load_b          <= 1'b0;
    load_mult       <= 1'b0;
    load_output_reg <= 1'b0;
    multiply        <= 1'b0;
    subtract        <= 1'b0;
    mult_out_select <= 1'b0;
    fbr_input       <= 1'b0;

    case (state)
      s_reset: begin
        if (ReadyIn_rise) state <= s_read_re_w;
      end
      s_read_re_w: begin
        if (ReadyIn_rise) begin
          state <= s_read_im_w;
          load_coeff <= 1'b1;
        end
      end
      s_read_im_w: begin
        if (ReadyIn_rise) begin
          state <= s_read_re_b;
          load_coeff <= 1'b1;
        end
      end
      s_read_re_b: begin
        if (ReadyIn_rise) begin
          state <= s_read_im_b;
          load_b <= 1'b1;
        end
      end
      s_read_im_b: begin
        if (ReadyIn_rise) begin
          state <= s_load_mult;
          load_b <= 1'b1;
        end
      end
      s_load_mult: begin
        if (ReadyIn_fall) begin
          state <= s_read_re_a;
          load_b <= 1'b1;
          load_mult <= 1'b1;
        end
      end
      s_read_re_a: begin
        if (ReadyIn_rise) begin
          state <= s_mult2;
          fbr_input <= 1'b1;
          load_mult <= 1'b1;
          load_output_reg <= 1'b1;
          multiply <= 1'b1;
          subtract <= 1'b1;
        end
      end
      s_mult2: begin
        if (ReadyIn_fall) begin
          state <= s_read_im_a;
          multiply <= 1'b1;
          subtract <= 1'b0;
        end
      end
      s_read_im_a: begin
        if (ReadyIn_rise) begin
          state <= s_disp_im_y;
          fbr_input <= 1'b1;
          load_output_reg <= 1'b1;
          subtract <= 1'b0;
        end
      end
      s_disp_im_y: begin
        if (ReadyIn_rise) begin
          state <= s_disp_re_z;
          fbr_input <= 1'b0;
          load_output_reg <= 1'b1;
          mult_out_select <= 1'b1;
          subtract <= 1'b0;
        end
      end
      s_disp_re_z: begin
        if (ReadyIn_rise) begin
          state <= s_disp_im_z;
          fbr_input <= 1'b0;
          load_output_reg <= 1'b1;
          mult_out_select <= 1'b0;
          subtract <= 1'b1;
        end
      end
      s_disp_im_z: begin
        if (ReadyIn_rise) begin
          state <= s_read_re_b;
          fbr_input <= 1'b0;
          load_output_reg <= 1'b1;
          mult_out_select <= 1'b1;
          subtract <= 1'b1;
        end
      end
      default: begin
        state <= s_reset;       
      end
  endcase
  end
end
  
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
    led <= '0;
    feedback <= '0;
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


// Logiclock needed for this to implement in one region properly
// https://community.intel.com/t5/Programmable-Devices/Inferring-two-multipliers-in-one-DPS-block-in-verilog-VHDL/m-p/158809
// https://www.intel.com/content/www/us/en/support/programmable/articles/000084312.html 
// https://www.intel.com/content/www/us/en/docs/programmable/683082/23-1/inferring-multiply-accumulator-and-multiply.html
// https://community.intel.com/t5/Intel-Quartus-Prime-Software/Specific-to-Logic-lock-chip-planner/td-p/710447

// Result = dataa_0*datab_0 +/- dataa_1*datab_1
/*
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
*/

mult_add_inferred multiplier(
  .result(result),          //  result.result
  .dataa_0({ {8{re_w_pipeline[7] }}, re_w_pipeline}),  // Re(w) reg -sign extended to 16 bits (chipverify.com)
  .dataa_1({ {8{data_in[7]       }}, data_in      }),  // Im(w) reg
  .datab_0({ b_pipeline_0          , 8'd0         }),  // mult0 -left shifted for fixed point
  .datab_1({ b_pipeline_1          , 8'd0         }),  // mult1
  .addnsub1(subtract),  // addnsub1, use_subnadd=1
  .ena0(load_coeff),    // load w
  .ena1(load_mult),     // load mult 0, 1
  .ena2(multiply) ,     // output reg enable
  .aclr0(reset), .aclr1(reset), .aclr2(reset),  // Async active high reset
  .clock0(clk), .clock1(clk), .clock2(clk)      // common clk
);

endmodule

module mult_add_inferred(
  output reg [32:0] result,
  input wire [15:0] dataa_0, dataa_1, datab_0, datab_1,
  input wire clock0, clock1, clock2,
  input wire ena0, ena1, ena2,
  input wire aclr0, aclr1, aclr2, addnsub1
);

// Input registers
reg [15:0] dataa_0_reg, dataa_1_reg, datab_0_reg, datab_1_reg;
always @(posedge clock0, posedge aclr0) begin
  if (aclr0) begin
    dataa_0_reg <= 16'd0;
    dataa_1_reg <= 16'd0;
    datab_0_reg <= 16'd0;
    datab_1_reg <= 16'd0;
  end else begin
    if (ena0) begin
      dataa_0_reg <= dataa_0;
      dataa_1_reg <= dataa_1;
      datab_0_reg <= datab_0;
      datab_1_reg <= datab_1;      
    end
  end
end

// Multipliers and output reg
always @(posedge clock2, posedge aclr2) begin
  if (aclr2) begin 
    result <= 33'd0;
  end else begin
    if (ena2) begin
      if (addnsub1) result <=  dataa_0_reg*datab_0_reg + dataa_1_reg*datab_1_reg;
      else result <=  dataa_0_reg*datab_0_reg - dataa_1_reg*datab_1_reg;
    end
  end
end
  
endmodule

`default_nettype wire