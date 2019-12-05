module IEU #(parameter Width = 32)
(input [Width-1:0] PC, RD1, RD2, Immediatevalue, 
input [4:0] Rd, [3:0] Alucontrolinput, [8:0] controlsignal,
input [4:0] RS1,RS2,Rd2,Rd1,
input [Width-1:0] ALUIN,Writedatain,
output zero, [Width-1:0] ALUresult, branchaddress, RD22,
output [4:0] rd, [5:0] controlSignal);

wire [1:0] ForwardA,ForwardB;
wire [Width-1:0] immediateout,ALUinput1,MUXout,ALUinput2,Branchaddress,ALuresult;
wire Zero;
wire [3:0] Alucontrol;
forwarding F1(controlsignal[6],RS1,RS2,Rd1,Rd2,ForwardA,ForwardB);
shift #(Width)S1(Immediatevalue,immediateout);
add #(Width)A1(PC,immediateout,Branchaddress);
MUX1 #(Width)M5(RD1,Writedatain,ALUIN,ForwardA,ALUinput1);
MUX1 #(Width)M6(RD2,Writedatain,ALUIN,ForwardB,MUXout);
MUX #(Width)M2(MUXout,Immediatevalue,controlsignal[8],ALUinput2);
ALUControl A2(controlsignal[1:0],Alucontrolinput[3],Alucontrolinput[2:0],Alucontrol);
ALU #(Width)A3(Alucontrol,ALUinput1,ALUinput2,ALuresult,Zero);


assign branchaddress = Branchaddress;
assign ALUresult = ALuresult;
assign zero = Zero;
assign rd = Rd;
assign RD22 = RD2;
assign controlSignal = controlsignal[7:2];
endmodule  