module ctrlunit(
		input [6:0] op,
		input [2:0] funct3,
		input funct75, ZF, SF,
		output reg [1:0] Immsrc,
		output reg [2:0] ALUctrl,
		output reg regw, ALUsrc, memw, RESsrc, PCsrc
		);
		
	reg [1:0] ALUop;
	reg Branch;
	
	
	
	parameter ldwd=7'b000_0011, stwd=7'b010_0011, RT=7'b011_0011, IT=7'b001_0011, BT=7'b110_0011;
	
	
	
	always @ (*)
	begin
		case (op)
		ldwd: {regw, Immsrc, ALUsrc, memw, RESsrc, Branch, ALUop} = 9'b100101000;
	
		stwd: {regw, Immsrc, ALUsrc, memw, RESsrc, Branch, ALUop} = 9'b00111X000;

		RT: {regw, Immsrc, ALUsrc, memw, RESsrc, Branch, ALUop} = 9'b1XX000010;
		
		IT: {regw, Immsrc, ALUsrc, memw, RESsrc, Branch, ALUop} = 9'b100100010;
		
		BT: {regw, Immsrc, ALUsrc, memw, RESsrc, Branch, ALUop} = 9'b01000X101;
		
		default: {regw, Immsrc, ALUsrc, memw, RESsrc, Branch, ALUop} = 9'b000000000;
		
		endcase
		
	end
	
	
	always @ (*)
	begin
		case(funct3)
			3'b000: PCsrc = ZF & Branch;
			3'b001: PCsrc = ~ZF & Branch;		
			3'b100: PCsrc = SF & Branch;
			default: PCsrc = 1'b0;
		endcase
	end
	
	always @ (*)
	begin
		case (ALUop)
		7'b00: ALUctrl = 3'b000;
	
		7'b01: if(funct3 == 3'b000 || funct3 == 3'b001 || funct3 == 3'b100) ALUctrl = 3'b010;
						else ALUctrl = 3'b010;
		
		7'b10: if(funct3 == 3'b000 & ({op[5],funct75}==2'b00 || {op[5],funct75}==2'b01 || {op[5],funct75}==2'b10)) begin ALUctrl = 3'b000; end	
						else if (funct3 == 3'b000 & {op[5],funct75}==2'b11) begin ALUctrl = 3'b010; end
						else if (funct3 == 3'b001) begin ALUctrl = 3'b001; end
						else if (funct3 == 3'b100) begin ALUctrl = 3'b100; end
						else if (funct3 == 3'b101) begin ALUctrl = 3'b101; end
						else if (funct3 == 3'b110) begin ALUctrl = 3'b110; end
						else  begin ALUctrl = 3'b111; end
		default: ALUctrl = 3'b000;
		
		endcase
		
	end
endmodule