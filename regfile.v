module regfile(
	input [4:0] Re_addr1, Re_addr2, wr_addr,
	input [31:0] Din,
	input wr_en, clk, arst,
	output reg [31:0] Dout1, Dout2);

	reg [31:0] reg_arr [0:31];
	integer i;

	always @ (posedge clk or negedge arst) begin
		if(!arst) begin
			for (i=0; i<32; i=i+1) reg_arr[i]<=32'b0;
		end
		else if (wr_en) begin
			reg_arr[wr_addr] <= Din;
		end		
	end
	
	always @ (*) begin
		Dout1 <= reg_arr[Re_addr1];
		Dout2 <= reg_arr[Re_addr2];
	end
	
	
endmodule