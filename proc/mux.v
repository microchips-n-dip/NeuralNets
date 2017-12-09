// n-way mux
module Mux(q, in, o);

parameter switch_bits = 1;
parameter data_width = 8;

parameter n_cell = 1 << switch_bits;

input [switch_bits-1:0] q;
input [data_width-1:0] in [0:n_cell-1];
output [data_width-1:0] o;

genvar i;

generate
for (i = 0; i < n_cell; i = i + 1)
begin
  assign mux[i] = in[i];
end
endgenerate

assign o = mux[q];

endmodule

// 2-way mux
module Mux2(q, a, b, o);

parameter data_width = 8;

input q;
input [data_width-1:0] a;
input [data_width-1:0] b;
output [data_width-1:0] o;

Mux #(1, data_width) mux(q, {a, b}, o);

endmodule
