module hazardunit
(input MemRead, [4:0] RS1,RS2,RD,
output controlmux,PCen,IFIDen);

assign controlmux = (MemRead == 1'b0) ? 1 : (RD == RS1 | RD == RS2) ? 0 : 1;
assign PCen = (MemRead == 1'b0) ? 1 : (RD == RS1 | RD == RS2) ? 0 : 1;
assign IFIDen = (MemRead == 1'b0) ? 1 : (RD == RS1 | RD == RS2) ? 0 : 1;
endmodule

