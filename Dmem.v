module Dmem(
	input [31:0] addr,
	input we, clk, arst,
	input [31:0] WD,
	output reg [31:0] RD);

reg [31:0] mem [0:63];
integer i;
	always @ (posedge clk, negedge arst) begin
		if(!arst) begin
			for (i=0; i<64; i=i+1) mem[i]<=32'b0;
		end
		else if (we) begin
			mem[addr[31:2]] <= WD;
		end		
	end
	
	always @ (*) begin
		RD = mem[addr[31:2]];
	end
	
endmodule