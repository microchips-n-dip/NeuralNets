`include "misc.v"

module CounterModule(clk, en, rst_min, rst_max, inc_dec, val, carry);

input clk;
input en;
input rst_min;
input rst_max;
input inc_dec;
output val;

TFF tff0(clk, rst_max, rst_min, en, val);
assign carry = (inc_dec ^ val) & en;

endmodule

module Counter(clk, en, ld, rst_min, rst_max, inc_dec, min, max, ld_val, val);

parameter width = 8;

input clk;
input en;
input ld;
input rst_min;
input rst_max;
input inc_dec;
output min;
output max;
input [width-1:0] ld_val;
output [width-1:0] val;

wire carry [0:width];
assign carry[0] = en;
wire min_check [0:width];
assign min_check[0] = 1;
wire max_check [0:width];
assign max_check[0] = 1;

genvar i;
generate
for (i = 0; i < width; i = i + 1)
begin
  CounterModule cm0(clk, (~ld & carry[i]) | (ld & ld_val[i]), rst_min, rst_max, inc_dec, val[i], carry[i + 1]);
  min_check[i + 1] = min_check[i] & ~val[i];
  max_check[i + 1] = max_check[i] &  val[i];
end
endgenerate

assign min = min_check[width];
assign max = max_check[width];

endmodule
