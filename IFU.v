module IFU #(parameter Width = 32)
(input clk,Asel,PCen,[Width-1 : 0] PCPlus4, [Width-1 : 0] branchaddress,
output [Width-1 : 0] PC, Instruction);

wire [Width-1:0] PC1,P,RD;

MUX #(Width) M1(PCPlus4,branchaddress,Asel,PC1);
PCCounter #(Width) P1(clk,PCen,PC1,P);
adder #(Width) A1(P,PCPlus4);
instructionmemory #(Width) I1(P,RD);

assign PC = P;
assign Instruction = RD;
//end 
endmodule
