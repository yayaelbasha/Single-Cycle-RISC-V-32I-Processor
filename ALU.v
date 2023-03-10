module ALU (
	    output ZF, 
		output SF,
		output reg CF, 
		output reg [31:0] result, 
	    input [31:0] A,
		input [31:0] B, 
	    input [2:0] opcode);

	assign ZF = ~|result;
	assign SF = result[31];
	
	parameter ADD=3'b000, SHL=3'b001, SUB=3'b010, XOR=3'b100, SHR=3'b101, OR=3'b110, AND=3'b111;
	always @ (*)
	begin
		case (opcode)
			ADD: {CF,result} = A + B;
			SHL: {CF,result} = A << B;
			SUB: {CF,result} = A - B;
			XOR: {CF,result} = A ^ B;
			SHR: {CF,result} = A >> B;
			OR: {CF,result} = A | B;
			AND: {CF,result} = A & B;
			default: {CF,result} = 33'b0;
		endcase
	end
			
endmodule
