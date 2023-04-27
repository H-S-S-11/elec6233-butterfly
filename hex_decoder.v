// 4-bit binary to 7 segment decoder

module hex_decoder(
  input wire [3:0] value,
  output reg [6:0] segments
);

always @(*) begin
  case (value)
    4'd0:  segments = 7'b1000000;
    4'd1:  segments = 7'b1111001;
    4'd2:  segments = 7'b0100100;
    4'd3:  segments = 7'b0110000;
    4'd4:  segments = 7'b0011001;
    4'd5:  segments = 7'b0010010;
    4'd6:  segments = 7'b0000010;
    4'd7:  segments = 7'b1111000;
    4'd8:  segments = 7'b0000000;
    4'd9:  segments = 7'b0011000;
    4'd10: segments = 7'b0001000;
    4'd11: segments = 7'b0000011;
    4'd12: segments = 7'b0100111;
    4'd13: segments = 7'b0100001;
    4'd14: segments = 7'b0000110;
    4'd15: segments = 7'b0001110;    
    default: segments = 7'b1111111;
  endcase
end
  
endmodule