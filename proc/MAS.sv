`ifndef JPU_MAS_SVH
`define JPU_MAS_SVH

`include "mux.sv"

// Access servicer module
// Uses the internal flop to decide which input to service first in case of a conflict
// State changes only occur on conflict
module ASM(clk, cpl, a_req, b_req, d0_IN, d1_IN, ccl, a_serv, b_serv, data_OUT, active);

parameter data_width = 132;

// I/O
input clk; // Clock line
input cpl; // Conflict on Previous Layer
input a_req; // Input A request
input b_req; // Input B request
input [data_width-1:0] d0_IN; // Input A requested address (needs work)
input [data_width-1:0] d1_IN; // Input B requested address
output ccl; // Conflict on Current Layer
output a_serv; // Servicing A
output b_serv; // Servicing B
output [data_width-1:0] data_OUT; // Address requested by serviced input
output active; // Active flag

// Flop register
reg flop;

// Determine conflict and active states
assign active = a_req || b_req;
wire conflict = a_req && b_req;
assign ccl = conflict;
wire en_flop = conflict && ~cpl;

// Mux for switching between conflict and non-conflict mode
// Determines future mux states
wire conflict_switch;
Mux2 #(1) mux0(conflict, b_req, flop, conflict_switch);

// Mux for determining out address
Mux2 #(data_width) mux1(conflict_switch, d0_IN, d1_IN, data_OUT);

// Servicing requests based on flop with pull up
wire a_serv_active = !flop || !conflict;
wire b_serv_active = flop || !conflict;

// Determine serviced request
assign a_serv = a_serv_active && a_req;
assign b_serv = b_serv_active && b_req;

// Update flop if conflict occurs
always @(posedge clk)
begin
  if (en_flop) begin
    flop <= !flop;
  end
end

endmodule

module Injector(clk, req, data_IN, data_OUT, active);

parameter n_inputs = 8;
parameter data_width = 128;

parameter remaining = n_inputs % 2;
parameter n_layer = (n_inputs >> 1) + remaining;
parameter n_inject = n_layer - 1;

typedef struct {
  bit conflict;
  bit a_serv;
  bit b_serv;
  bit [data_width-1:0] serv_dat;
  bit active;
} InjectorWireBundle;

input clk;
input req [0:n_inputs-1];
input [data_width-1:0] data_IN [0:n_inputs-1];
output [data_width-1:0] data_OUT;
output active;

genvar i;

generate
InjectorWireBundle il_bundle [0:n_layer];
InjectorWireBundle in_bundle [0:n_inject];
for (i = 0; i < n_inject - remaining; i = i + 1)
begin
  parameter i1 = i + remaining;
  parameter i2 = (i << 1) + remaining;
  ASM #(data_width) asm1(clk, 1'b0,
    req[i2],                req[i2 + 1],
    data_IN[i2],            data_IN[i2 + 1],
    in_bundle[i1].conflict,
    in_bundle[i1].a_serv,   in_bundle[i1].b_serv,
    in_bundle[i1].serv_dat, in_bundle[i1].active);
end
if (remaining > 0)
begin
  assign in_bundle[0].conflict = 0;
  assign in_bundle[0].a_serv   = 0;
  assign in_bundle[0].b_serv   = 0;
  assign in_bundle[0].serv_dat = data_IN[n_inputs - 1];
  assign in_bundle[0].active   = req[n_inputs - 1];
end
assign il_bundle[0] = in_bundle[0];
for (i = 1; i < n_layer; i = i + 1)
begin
  ASM #(data_width) asm(clk,
    il_bundle[i + 1].conflict | in_bundle[i].conflict,
    il_bundle[i + 1].active,    in_bundle[i].active,
    il_bundle[i + 1].serv_dat,  in_bundle[i].serv_dat,
    il_bundle[i + 2].conflict,
    il_bundle[i + 2].a_serv,    il_bundle[i + 2].b_serv,
    il_bundle[i + 2].serv_dat,  il_bundle[i + 2].active);
end
endgenerate

assign data_OUT = il_bundle[n_layer].serv_dat;
assign active = il_bundle[n_layer].active;

endmodule

module Tree(clk, req, data_IN, data_OUT, active);

parameter n_inputs = 8;
parameter data_width = 128;

parameter n_layer = $clog2(n_inputs);
parameter n_modules = 1 << n_layer;

typedef struct {
  bit conflict;
  bit a_serv;
  bit b_serv;
  bit [data_width-1:0] serv_dat;
  bit active;
} TreeWireBundle;

input clk;
input req [0:n_inputs-1];
input [data_width-1:0] data_IN [0:n_inputs-1];
output [data_width-1:0] data_OUT;
output active;

genvar i;
genvar j;

generate
TreeWireBundle il_bundles [0:n_modules];
for (i = 0; i < n_inputs; i = i + 1)
begin
  assign il_bundles[i].conflict = 0;
  assign il_bundles[i].a_serv   = 0;
  assign il_bundles[i].b_serv   = 0;
  assign il_bundles[i].serv_dat = data_IN[i];
  assign il_bundles[i].active   = req[i];
end
for (i = 1; i < n_layer; i = i + 1)
begin
  parameter i1 = i + 1;
  parameter next_layer = 1 << i1;
  parameter layer_size = n_inputs >> i;
  for (j = 0; j < layer_size; j = j + 1)
  begin
    parameter j2 = j << 1;
    parameter j3 = j2 + 1;
    parameter l1 = next_layer + j;
    ASM #(data_width) asm(clk,
      il_bundles[j2].conflict | il_bundles[j3].conflict,
      il_bundles[j2].active,    il_bundles[j3].active,
      il_bundles[j2].serv_dat,  il_bundles[j3].serv_dat,
      il_bundles[l1].conflict,
      il_bundles[l1].a_serv,    il_bundles[l1].b_serv,
      il_bundles[l1].serv_dat,  il_bundles[l1].active);
  end
end
endgenerate

assign data_OUT = il_bundles[n_layer].serv_dat;
assign active = il_bundles[n_layer].active;

endmodule

module AST(clk, req, data_IN, data_OUT, active);

parameter n_inputs = 8;
parameter data_width = 128;

parameter log2 = $clog2(n_inputs);
parameter rex = 1 << (log2 - 1);
parameter n_inject = n_inputs - rex;

input clk;
input req [0:n_inputs-1];
input [data_width-1:0] data_IN [0:n_inputs-1];
output [data_width-1:0] data_OUT;
output active;

wire [data_width-1:0] tree_out;
wire tree_active;
Tree #(rex, data_width) tree(clk, req[0:rex-1], data_IN[0:rex-1],
  tree_out, tree_active);
wire inj_req [0:n_inject-1] = {req[rex:n_inputs-1], tree_active};
wire [data_width-1:0] inj_data_in [0:n_inject-1]
  = {data_IN[rex:n_inputs-1], tree_out};
Injector #(n_inject, data_width) inj(clk, inj_req, inj_data_in,
  data_OUT, active);

endmodule

`endif
