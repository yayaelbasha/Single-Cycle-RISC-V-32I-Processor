module NPCcalc(
		input PCSrc,
		input [31:0] PC,
		input [31:0] ImmExt,
		output reg [31:0] PCnext);
		
	always @(*)
	begin
		case (PCSrc)
			1'b0: PCnext = PC + 3'd4;
			1'b1: PCnext = PC + ImmExt;
			default: PCnext = PC + 3'd4;
		endcase
	end
	
endmodule