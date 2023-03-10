module muxALU(
	input [31:0] in0, in1,
	input src,
	output reg [31:0] out);
	
	always @ (*)
	begin
		case (src)
			1'b0: out = in0;
			1'b1: out = in1;
			default: out = in0;
		endcase
	end
	
endmodule