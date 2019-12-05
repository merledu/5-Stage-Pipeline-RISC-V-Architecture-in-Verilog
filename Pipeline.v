module Pipeline(input clk);
wire [31:0] N1,N2,N6,N7,N8,N9, N10,N11,N12, N16,N17,N18,PCPlus4;
wire [4:0] N3; // destination reg
wire [3:0] N4; // Alu controller input
wire [8:0] N5; // control signals
wire N13; // zero bit
wire [4:0] N14; // destination reg
wire [5:0] N15; // control signal
wire N21,N22;
wire [31:0] N23;
wire [4:0] N24;
wire [2:0] N19; // controlsignal
wire [4:0] N20; // destination reg
wire [4:0] N25, N26; // RS1 and RS2 field 
reg [31:0]IFID1, IFID2;
reg [31:0] IDEU1, IDEU2, IDEU3, IDEU4;
reg [4:0] IDEU5;
reg [3:0] IDEU6;
reg [8:0] IDEU7;
reg [31:0] EUMA1,EUMA2,EUMA3;
reg EUMA4; // zero bit
reg [4:0] EUMA5; // destination reg
reg [5:0] EUMA6; // control signal
reg [31:0] MAWB1, MAWB2, MAWB3;
reg [2:0] MAWB4; // controlsignal
reg [4:0] MAWB5; // destination reg
reg Asel,RegWrite;
reg [31:0] Writedata;
reg [4:0] Rd;
reg [4:0] IDEU8;
reg [4:0] IDEU9;
wire N27,N28;
reg PCen, IFIDen;
always @(posedge clk)
begin
if(IFIDen == 0)
begin
IFID2 <= IFID2;
IFID1 <= IFID1;
end
else
begin
IFID2 <= N2; // Instruction
IFID1 <= N1; // PC
end
IDEU1 <= N6; // PC
IDEU2 <= N7; //RD1
IDEU3 <= N8; // RD2 
IDEU4 <= N9; // Immediate value 
IDEU5 <= N3; // destination reg
IDEU6 <= N4; // funct7 + funct3
IDEU7 <= N5; // control signals
IDEU8 <= N25; // RS1
IDEU9 <= N26; //RS2
IFIDen <= N28; // IFIDen
EUMA1 <= N10; // ALU Result 
EUMA2 <= N11; // branchaddress
EUMA3 <= N12; // RD2
EUMA4 <= N13; // zero
EUMA5 <= N14; //Destination reg
EUMA6 <= N15; // control signals
MAWB1 <= N16; // branch address
MAWB2 <= N17; // Memory Data
MAWB3 <= N18; // ALU Result
MAWB4 <= N19; // conrol signal
MAWB5 <= N20; // Destination reg
Asel <= N21;
RegWrite <= N22;
Writedata <= N23;
Rd <= N24;
PCen <= N27;
end
IDU #(32)D1(clk,RegWrite,IFID1,IFID2,Writedata,Rd,IDEU5,IDEU7[5],N7,N8,N6,N9,N3,N4,N5,N25,N26,N27,N28);
IFU #(32)F1(clk,Asel,PCen,PCPlus4,N16,N1,N2);
IEU #(32)E1(IDEU1,IDEU2,IDEU3,IDEU4,IDEU5,IDEU6,IDEU7,IDEU8,IDEU9,MAWB5,EUMA5,EUMA1,MAWB3,N13,N10,N11,N12,N14,N15);
MAU #(32)M1(clk,EUMA2,EUMA1,EUMA3,EUMA4,EUMA6,EUMA5,N16,N17,N18,N21,N19,N20);
WBU #(32)W1(MAWB2,MAWB3,MAWB4,MAWB5,N22,N23,N24);

//
//
//
endmodule

