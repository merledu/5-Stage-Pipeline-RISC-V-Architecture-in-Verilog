module WBU #(parameter Width = 32) 
(input [Width-1:0] RD,ALUResult, [2:0] controlsignal, [4:0] Rd,
output RegWrite, [Width-1:0] Writeback, [4:0] rd);

wire [Width-1:0] writeback;
MUX #(Width)M1(ALUResult,RD,controlsignal[2],writeback);

assign Writeback = writeback;
assign rd = Rd;
assign RegWrite = controlsignal[1];

endmodule
