`include "vl_global_functions.sv"

`include "misc.v"
`include "MAS.v"

import vl_global_functions::*;

// Node router
module NodeRouter(clk, in_stream, out_stream);

// Network parameters
parameter layer_id = 1;
parameter net_width = 4;
parameter nw_dims = 2;

// Data width parameter
parameter data_width = 128;

// Network offsets and stream count
parameter nw_full = 2 * nw_dims;
parameter n_stream = nw_full + 1;
parameter net0_offset = nw_full * (layer_id - 0);
parameter naddr0_end = nw_full + net0_offset;
parameter net1_offset = nw_full * (layer_id - 1);
parameter naddr1_end = nw_full + net1_offset;

// Address parameters
parameter local_id = 0;
parameter upper_id = 0;

// Stream width
parameter stream_width = data_width + net_width;

input clk;
input [stream_width-1:0] in_stream [0:n_stream-1];
output [stream_width-1:0] out_stream [0:n_stream-1];

genvar i;
genvar j;
genvar k;
genvar l;
genvar nei [0:n_stream-2];

// Generate the circuit dynamically
generate
for (i = 0; i < nw_dims; i = i + 1)
begin
  // Determining neighbor addresses
  // Neighbors addresses are genvars so on comparison they are known
  //  since compile time
  nei[i:i+1] = compute_nei(i, local_id);
end
// "via" matrix
wire via [0:n_stream-1] [0:n_stream-1];
for (i = 0; i < n_stream; i = i + 1)
begin
  // Fetch requested address from stream
  wire [net_width-1:0] naddr_req;
  assign naddr_req = in_stream[i][stream_width-1:stream_width-net_width];
  // Determine if we need to end to node 0 of this layer
  wire cond_local = naddr_req[naddr1_end-1:net1_offset] == upper_id;
  wire via_prev[0:nw_dims];
  assign via_prev[0] = 0;
  for (j = 0; j < n_stream >> 1; j = j + 1)
  begin
    k = 2 * j;
    l = 1 + k;
    // Address for sending data on this layer
    wire [nw_full-1:0] addr;
    assign addr = cond_local ? naddr_req[l + net0_offset:k + net0_offset] : 0;
    // Compute "via"-s
    assign via[k][i] = (addr == nei[k]) & ~via_prev[j];
    assign via[l][i] = (addr == nei[l]) & ~via_prev[j];
    assign via_prev[j + 1] = via[k][i] | via[l][i] | via_prev[j];
  end
  // If no corresponding address has been found, logically we send to the local node
  assign via[n_stream][i] = ~via_prev[nw_dims];
end
AST #(n_stream, stream_width) ast(clk, via, in_stream, out_stream);
endgenerate

endmodule

// Core router
module CoreRouter(clk, in_stream, out_stream);

// Network parameters
parameter layer_id = 2;
parameter net_width = 4;
parameter nw_dims = 2;

// Data width parameter
parameter data_width = 128;

// Network offset and stream count
parameter nw_full = 2 * nw_dims;
parameter n_stream = 2 * nw_full;
parameter net0_offset = nw_full * (layer_id - 0);
parameter naddr0_end = nw_full + net0_offset;
parameter net1_offset = nw_full * (layer_id - 1);
parameter naddr1_end = nw_full + net1_offset;
parameter net2_offset = nw_full * (layer_id - 2);
parameter naddr2_end = nw_full + net2_offset;

// Address parameters
parameter local_id = 0;
parameter upper0_id = 0;
parameter upper1_id = 0;

// Stream width
parameter stream_width = data_width + net_width;

input clk;
input [stream_width-1:0] in_stream [0:n_stream-1];
output [stream_width-1:0] out_stream [0:n_stream-1];

genvar i;
genvar j;
genvar k;
genvar l;
genvar nei_lower [0:n_stream-1];
genvar nei_upper [0:n_stream-1];

// Generate the circuit dynamically
generate
for (i = 0; i < nw_dims; i = i + 1)
begin
  // Determining neighbor addresses
  // Neighbors addresses are genvars so on comparison they are known
  //  since compile time
  nei_lower[i:i+1] = compute_nei(i, local_id);
  nei_upper[i:i+1] = compute_nei(i, upper0_id);
end
// "via" matrices
wire via_lower [n_stream-1][n_stream-1];
wire via_upper [n_stream-1][n_stream-1];
for (i = 0; i < n_stream; i = i + 1)
begin
  // Fetch requested address from stream
  wire [nw_full2-1:0] naddr_req;
  assign naddr_req = in_stream[i][stream_width-1:stream_width-net1_offset];
  // Determine if we need to end to node 0 of this layer
  wire cond_local_lower = naddr_req[naddr1_end-1:net1_offset] == upper0_id;
  wire cond_local_upper = naddr_req[naddr2_end-1:net2_offset] == upper1_id;
  wire via_prev_lower [0:nw_dims];
  assign via_prev_lower[0] = 0;
  wire via_prev_upper [0:nw_dims];
  assign via_prev_upper[0] = 0;
  for (j = 0; j < n_stream >> 2; j = j + 1)
  begin
    k = 2 * j;
    l = 1 + k;
    // Address for sending data on this layer
    wire [nw_full-1:0] addr_lower;
    assign addr_lower = cond_local_lower ? naddr_req[l + naddr0_end:k + net0_offset] : 0;
    // Compute "via"-s
    assign via_lower[k][i] = (addr_lower == nei_lower[k]) & ~via_prev_lower[j];
    assign via_lower[l][i] = (addr_lower == nei_lower[l]) & ~via_prev_lower[j];
    assign via_prev_lower[j + 1] = via_lower[k] | via_lower[l] | via_prev_lower[j];
    assign via[k][i] = via_lower[k][i];
    assign via[l][i] = via_lower[l][i];
    // Address for sending data on upper layer
    wire [nw_full-1:0] addr_upper;
    assign addr_upper = cond_local_upper ? naddr_req[l + naddr1_end:k + net1_offset] : 0;
    // Compute "via"-s
    assign via_upper[k][i] = (addr_upper == nei_upper[k]) & ~via_prev_upper[j];
    assign via_upper[l][i] = (addr_upper == nei_upper[l]) & ~via_prev_upper[j];
    assign via_prev_upper[j + 1] = via_upper[k] | via_upper[l] | via_prev_upper[j];
    assign via[k + (n_stream >> 1)] = via_upper[k][i];
    assign via[l + (n_stream >> 1)] = via_upper[l][i];
  end
end
// Construct upper and lower accessor trees from "via"-s
AST #(n_stream, stream_width) ast(clk, via, in_stream, out_stream);
endgenerate

endmodule
