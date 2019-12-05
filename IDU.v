module IDU #(parameter Width = 32)
(input clk,RegWrite,[Width-1:0] PC1, Instruction,WriteData,
input [4:0] Rd,RD,
input Memread,
output [Width-1:0] RD1,RD2,PC,immediatevalue,
output [4:0] rd, [3:0] ALUcontrolinput,
output [8:0] control, [4:0] RS1,RS2,
output PCen,IFIDen);

wire controlmux,Pcen,ifid;
wire [Width-1:0] RD11,RD22,immediateOut;
wire [1:0] ALUop;
wire ALUSrc,MemtoReg,Regwrite,MemRead,MemWrite,Branch,jump;

hazardunit H1(Memread,Instruction[19:15],Instruction[24:20],RD,controlmux,Pcen,ifid);
mainController C1(Instruction[6:0],ALUSrc,MemtoReg,Regwrite,MemRead,MemWrite,Branch,jump,ALUop);
Registerfile #(Width) R1(clk,RegWrite,Instruction[19:15],Instruction[24:20],Rd,WriteData,RD11,RD22);
immediategeneration #(Width)I1(Instruction,immediateOut);
//always @(*)
//begin
assign PC = PC1;
assign control = (controlmux == 1'b1) ? {ALUSrc,MemtoReg,Regwrite,MemRead,MemWrite,Branch,jump,ALUop} : 0;
assign RD1 = RD11;
assign RD2 = RD22;
assign immediatevalue = immediateOut;
assign ALUcontrolinput = {Instruction[30],Instruction[14:12]};
assign rd = Instruction[11:7];
assign RS1 = Instruction[19:15];
assign RS2 = Instruction[24:20];
assign PCen = Pcen;
assign IFIDen = ifid;
//end
endmodule


