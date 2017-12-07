// Register with enable and reset
module Reg(clk, en, rst, data_IN, data_OUT)

parameter width = 8;

input clk;
input en;
input rst;
input [width-1:0] data_IN;
output [width-1:0] data_OUT;

reg [width-1:0] data;

genvar i;
generate
for (i = 0; i < width; i = i + 1)
begin
  data[i] = (clk & en & data_IN[i]) & ~rst;
end
endgenerate

assign data_OUT = data;

endmodule

// T-flipflop
module TFF(clk, s, r, t, q);

input clk;
input s;
input r;
input t;
output q;

reg flop;
assign flop = (clk & t & ~flop) | (s & ~r);
assign q = flop;

endmodule

// SR latch with enable
module SRE(clk, s0, r0, s1, r1, q);

input clk;
input s0;
input r0;
input s1;
input r1;
output q;

reg flop = 0;
wire s2 = s0 | (clk & s1);
wire r2 = r0 | (clk & r1);
flop = (s2 | flop) & ~r2;
assign q = flop;

endmodule

// 2-way mux
module Mux2(q, a, b, o);

parameter data_width = 8;

input q;
input [data_width-1:0] a;
input [data_width-1:0] b;
output [data_width-1:0] o;

wire [data_width-1:0] mux [0:1] = {a, b};
assign o = mux[q];

endmodule

// n-way mux
module Mux(q, in, o);

parameter switch_bits = 1;
parameter data_width = 8;

parameter tree0 = pow(2, switch_bits);
parameter tree1 = pow(2, switch_bits + 1) - 1;

input [switch_bits-1:0] q;
input [data_width-1:0] in [0:tree0 - 1];
output [data_width-1:0] o;

wire [data_width-1:0] serv_dat [0:tree1];

genvar i;
genvar j;
genvar k;
genvar l = 1;
genvar m;
genvar n;
genvar o;
genvar p;

generate
for (i = 0; i < tree0; i = i + 1)
begin
  assign serv_dat[i] = in[i];
end
n = tree1 - 1;
for (i = 0; i < switch_bits; i = i + 1)
begin
  p = 2 * l;
  n = n - p;
  for (j = 0; j < l; j = j + 1)
  begin
    o = 2 * j;
    m = n + o;
    k = n + p + j;
    Mux2 #(data_width) mux(q[i], serv_dat[m], serv_dat[m + 1], serv_dat[k]);
  end
  l = 2 * l;
end
endgenerate

assign o = serv_dat[tree1 - 1];

endmodule
