`include "misc.v"
`include "MAS.v"

module NodeRouter(clk, in_stream, out_stream);

parameter layer_id = 1;
parameter net_width = 4;
parameter nw_dims = 2;

parameter data_width = 128;

parameter nw_full = 2 * nw_dims;
parameter n_stream = nw_full + 1;
parameter net0_offset = nw_full * (layer_id - 0);
parameter naddr0_end = nw_full + net0_offset;
parameter net1_offset = nw_full * (layer_id - 1);
parameter naddr1_end = nw_full + net1_offset;

parameter local_id = 0;
parameter upper_id = 0;

parameter stream_width = data_width + net_width;

input clk;
input [stream_width-1:0] in_stream [0:n_stream-1];
output [stream_width-1:0] out_stream [0:n_stream-1];

genvar i;
genvar j;
genvar k;
genvar l;
genvar nei [0:n_stream-2];
generate
for (i = 0; i < nw_dims; i = i + 1)
begin
  j = 1 << (2 * i);
  k = (local_id >> j) % 4;
  nei[i] = (k + 1) % 3;
  nei[i + 1] = (k + 2) % 3;
end
wire via [0:n_stream-1] [0:n_stream-1];
for (i = 0; i < n_stream; i = i + 1)
begin
  wire [net_width-1:0] naddr_req;
  assign naddr_req = in_stream[i][stream_width-1:stream_width-net_width];
  wire cond_local = naddr_req[naddr1_end-1:net1_offset] == upper_id;
  wire via_prev[0:nw_dims];
  assign via_prev[0] = 0;
  for (j = 0; j < nw_dims; j = j + 1)
  begin
    k = 2 * j;
    l = 1 + k;
    wire [nw_full-1:0] addr;
    assign addr = cond_local ? naddr_req[l + net0_offset:k + net0_offset] : 0;
    assign via[k][i] = (addr == nei[k]) & ~via_prev[j];
    assign via[l][i] = (addr == nei[l]) & ~via_prev[j];
    assign via_prev[j + 1] = via[k][i] | via[l][i] | via_prev[j];
  end
  assign via[n_stream][i] = ~via_prev[nw_dims];
end
for (i = 0; i < n_stream; i = i + 1)
begin
  wire acti0;
  wire acti1;
  wire [stream_width-1:0] outi;
  AST #(2, stream_width) \
    ast(clk, via[i][0:n_stream-2], in_stream[0:n_stream-2], outi, acti0);
  AST #(1, stream_width) \
    asm(clk, {acti0, via[i][n_stream-1]}, {outi, in_stream[n_stream-1]}, out_stream[i], acti1);
end
endgenerate

endmodule

module CoreRouter(clk, in_stream, out_stream);

parameter layer_id = 2;
parameter net_width = 4;
parameter nw_dims = 2;

parameter data_width = 128;
parameter stream_width = data_width + net_width;

parameter nw_full = 2 * nw_dims;
parameter n_stream = 2 * nw_full;
parameter net0_offset = nw_full * (layer_id - 0);
parameter naddr0_end = nw_full + net0_offset;
parameter net1_offset = nw_full * (layer_id - 1);
parameter naddr1_end = nw_full + net1_offset;
parameter net2_offset = nw_full * (layer_id - 2);
parameter naddr2_end = nw_full + net2_offset;

parameter local_id = 0;
parameter upper0_id = 0;
parameter upper1_id = 0;

input clk;
input [stream_width-1:0] in_stream [0:n_stream-1];
output [stream_width-1:0] out_stream [0:n_stream-1];

genvar i;
genvar j;
genvar k;
genvar l;
genvar nei_lower [0:n_stream-1];
genvar nei_upper [0:n_stream-1];
generate
for (i = 0; i < nw_dims; i = i + 1)
begin
  j = 1 << (2 * i);
  k = (local_id >> j) % 4;
  l = (upper0_id >> j) % 4;
  nei_lower[i] = (k + 1) % 3;
  nei_lower[i + 1] = (k + 2) % 3;
  nei_upper[i] = (l + 1) % 3;
  nei_upper[i + 1] = (l + 2) % 3;
end
wire via_lower [n_stream-1][n_stream-1];
wire via_upper [n_stream-1][n_stream-1];
for (i = 0; i < n_stream; i = i + 1)
begin
  wire [nw_full2-1:0] naddr_req;
  assign naddr_req = in_stream[i][stream_width-1:stream_width-net1_offset];
  wire cond_local_lower = naddr_req[naddr1_end-1:net1_offset] == upper0_id;
  wire cond_local_upper = naddr_req[naddr2_end-1:net2_offset] == upper1_id;
  wire via_prev_lower [0:nw_dims];
  assign via_prev_lower[0] = 0;
  wire via_prev_upper [0:nw_dims];
  assign via_prev_upper[0] = 0;
  for (j = 0; j < nw_dims; j = j + 1)
  begin
    k = 2 * j;
    l = 1 + k;
    wire [nw_full-1:0] addr_lower;
    assign addr_lower = cond_local_lower ? naddr_req[l + naddr0_end:k + net0_offset] : 0;
    assign via_lower[k][i] = (addr_lower == nei_lower[k]) & ~via_prev_lower[j];
    assign via_lower[l][i] = (addr_lower == nei_lower[l]) & ~via_prev_lower[j];
    assign via_prev_lower[j + 1] = via_lower[k] | via_lower[l] | via_prev_lower[j];
    wire [nw_full-1:0] addr_upper;
    assign addr_upper = cond_local_upper ? naddr_req[l + naddr1_end:k + net1_offset] : 0;
    assign via_upper[k][i] = (addr_upper == nei_upper[k]) & ~via_prev_upper[j];
    assign via_upper[l][i] = (addr_upper == nei_upper[l]) & ~via_prev_upper[j];
    assign via_prev_upper[j + 1] = via_upper[k] | via_upper[l] | via_prev_upper[j];
  end
end
for (i = 0; i < n_stream / 2; i = i + 1)
begin
  k = 2 * i;
  l = 1 + k;
  wire acti0;
  wire acti1;
  wire [stream_width-1:0] outi0;
  AST #(2, stream_width) \
    ast(clk, via_lower[i][0:n_stream-2], in_stream[0:n_stream-2], outi0, acti0);
  AST #(1, stream_width) \
    asm(clk, {acti0, via_lower[i][n_stream-1]}, {outi0, in_stream[n_stream-1]}, out_stream[i], acti1);
  wire acti2;
  wire acti3;
  wire [stream_width-1:0] outi1;
  AST #(2, stream_width) \
    ast(clk, via_upper[i][0:n_stream-2], in_stream[0:n_stream-2], outi0, acti2);
  AST #(1, stream_width) \
    asm(clk, {acti0, via_upper[i][n_stream-1]}, {outi1, in_stream[n_stream-1]}, out_stream[i], acti3);
end
endgenerate

endmodule
