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
Mux2 #(data_width) mux1(conflict_switch, d0_IN, d1_IN, d_OUT);

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

module AST(clk, req, data_IN, data_OUT, active);

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
} ASTWireBundle;

input clk;
input req [0:n_inputs-1];
input [data_width-1:0] data_IN [0:n_inputs-1];
output [data_width-1:0] data_OUT;
output active;

genvar i;

generate
ASTWireBundle il_bundle [0:n_layer];
ASTWireBundle in_bundle [0:n_inject-1];
ASM #(data_width) asm0(clk, 0,
  req[0],                req[1],
  data_IN[0],            data_IN[1],
  il_bundle[0].conflict,
  il_bundle[0].a_serv,   il_bundle[0].b_serv,
  il_bundle[0].serv_dat, il_bundle[0].active);
for (i = 1; i < n_inject - remaining; i = i + 1)
begin
  ASM #(data_width) asm1(clk, 0,
    req[(i << 1)],         req[(i << 1) + 1],
    data_IN[(i << 1)],     data_IN[(i << 1) + 1],
    in_bundle[i].conflict,
    in_bundle[i].a_serv,   in_bundle[i].b_serv,
    in_bundle[i].serv_dat, in_bundle[i].active);
end
if (remaining > 0)
begin
  assign in_bundle[n_inject - 1].conflict = 0;
  assign in_bundle[n_inject - 1].a_serv = 0;
  assign in_bundle[n_inject - 1].b_serv = 0;
  assign in_bundle[n_inject - 1].serv_dat = data_IN[n_inputs - 1];
  assign in_bundle[n_inject - 1].active = req[n_inputs - 1];
end
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

`endif
