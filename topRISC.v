module topRISC(
	input clk, arst);

	wire ZF, SF, PCSrc, RESsrc, memw, ALUsrc, regw;
	wire [1:0] Immsrc;
	wire [2:0] ALUctrl;
	wire [31:0] PCnext, PC, Instr, SrcA, SrcB, ImmExt, ALUresult, Wdata, Rdata, result;
	

	NPCcalc calc1
	(
	.PCSrc(PCSrc),
	.PC(PC),
	.ImmExt(ImmExt),
	.PCnext(PCnext)
	);

	PCreg PCreg1
	(
	.PCnext(PCnext),
	.clk(clk), 
	.arst(arst), 
	.load(1'b1),
	.PC(PC)
	);
	
	ALU ALU1
	(
	.ZF(ZF), 
	.SF(SF),
	.result(ALUresult), 
	.A(SrcA),
	.B(SrcB), 
	.opcode(ALUctrl)
	);
	
	muxALU mux1(
	.in0(Wdata), 
	.in1(ImmExt),
	.src(ALUsrc),
	.out(SrcB));
	


	regfile regfile1
	(
	.Re_addr1(Instr[19:15]), 
	.Re_addr2(Instr[24:20]), 
	.wr_addr(Instr[11:7]),
	.Din(result),
	.wr_en(regw), 
	.clk(clk), 
	.arst(arst),
	.Dout1(SrcA), 
	.Dout2(Wdata)
	);
	
	
	ctrlunit ctrl1
	(
	.op(Instr[6:0]),
	.funct3(Instr[14:12]),
	.funct75(Instr[30]), 
	.ZF(ZF), 
	.SF(SF),
	.Immsrc(Immsrc), 
	.ALUctrl(ALUctrl),
	.regw(regw), 
	.ALUsrc(ALUsrc), 
	.memw(memw), 
	.RESsrc(RESsrc), 
	.PCsrc(PCSrc)
	);
	
	
	Dmem mem1
	(
	.addr(ALUresult),
	.we(memw), 
	.clk(clk),
	.arst(arst),
	.WD(Wdata),
	.RD(Rdata)
	);
	

	muxALU mux2(
	.in0(ALUresult), 
	.in1(Rdata),
	.src(RESsrc),
	.out(result));
	
	Imem mem2
	(
	.PC(PC),
	.RD(Instr)
	);
	
	extend ext1
	(
	.Instr(Instr),
	.Immsrc(Immsrc),
	.ImmExt(ImmExt)
	);



endmodule