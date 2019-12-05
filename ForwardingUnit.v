module forwarding(
input RegWrite, [4:0] RS1, RS2, RD1, RD2,
output reg [1:0] ForwardA , ForwardB);

// when forwardA and forwardB will be 00 so the register values will be given to ALU
// when forwardA and forwardB will be 10 so the operand will be prior ALU result
// when forwardA and forwardB will be 01 so the operand will be from data memory or prior ALU result.
always @(RegWrite or RD1 or RD2 or RS1 or RS2)
begin
if(RegWrite == 1 && RD1 != 0 && RD1 == RS1)  // Execution hazard
ForwardA <= 2'b10;
else if(RegWrite == 1 && RD2 != 0 && RD2 == RS1)  // Memory Hazard
ForwardA <= 2'b01; 
else 
ForwardA <= 2'b00;

if(RegWrite == 1 && RD1 != 0 && RD1 == RS2)
ForwardB <= 2'b10; 
else if(RegWrite == 1 && RD2 != 0 && RD2 == RS2)
ForwardB <= 2'b01; 
else
ForwardB <= 2'b00;

end

endmodule
