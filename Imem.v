module Imem(
	input [31:0] PC,
	output reg [31:0] RD);

reg [31:0] mem [0:63];

	initial 
	begin
	$readmemh("program",mem);
	end
	always @ (*) begin
	
		RD = mem[PC[31:2]];
	end
	
endmodule
