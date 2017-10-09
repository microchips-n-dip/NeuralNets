// Register with enable and reset
module Reg(clk, en, rst, data_IN, data_OUT)

parameter width = 8;

input clk;
input en;
input rst;
input [width-1:0] data_IN;
output [width-1:0] data_OUT;

reg [width-1:0] data;

always @(en and posedge clk)
begin
  data <= data_IN;
end

always @(rst)
begin
  data <= (width-1){1b'0};
end

assign data_OUT = data;

endmodule

// SR latch
module SR(s, r, q, qbar);

input s;
input r;
inout q;
inout qbar;

assign q = ~(r | qbar);
assign qbar = ~(s | q);

endmodule

module SRE(clk, s0, r0, s1, r1, q, qbar);

input clk;
input s0;
input r0;
input s1;
input r1;
inout q;
inout qbar;

assign q = ~((r1 & clk) | r0 | qbar);
assign qbar = ~((s1 & clk) | s0 | q);

endmodule
