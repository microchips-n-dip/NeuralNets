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
