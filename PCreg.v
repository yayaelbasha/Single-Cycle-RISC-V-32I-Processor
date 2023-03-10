module PCreg(
		input [31:0] PCnext,
		input clk, arst, load,
		output reg [31:0] PC);
		
	always @(posedge clk, negedge arst)
	begin
		if (!arst) begin
			PC <= 32'b0;
		end
		else if (load) begin
			PC <= PCnext;
		end
	end
	
endmodule