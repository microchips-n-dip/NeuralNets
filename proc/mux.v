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
