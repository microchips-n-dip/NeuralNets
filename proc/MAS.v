`include "misc.v"

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
  if (en_flop) begin
    flop <= !flop;
  end
end

endmodule

module AST(clk, req, data_IN, data_OUT, active);

parameter n_inputs = 8;
parameter data_width = 128;

input clk;
input req [0:n_inputs-1];
input [data_width-1:0] data_IN [0:n_inputs-1];
output [data_width-1:0] data_OUT;
output active;

genvar j;
genvar k;
genvar l;
genvar m;
genvar n;
genvar n_remain;
genvar prev_layer_modules;
genvar next_layer_modules;
genvar shift_modules;
genvar remain_modules;
genvar n_modules;

generate
prev_layer_modules = n_inputs;
while (prev_layer_modules > 1)
begin
  shift_modules = prev_layer_modules >> 1;
  remain_modules = prev_layer_modules % 2;
  next_layer_modules = shift_modules + remain_modules;
  n_modules = n_modules + prev_layer_modules;
  prev_layer_modules = next_layer_modules;
end
wire conflict [0:n_modules-1];
wire a_serv [0:n_modules-1];
wire b_serv [0:n_modules-1];
wire [data_width-1:0] serv_dat [0:n_modules-1];
wire actives [0:n_modules-1];
l = n_inputs;
for (j = 0; j < l; j = j + 1)
begin
  assign actives[i] = req[i];
  assign serv_dat[i] = data_IN[i];
  assign conflict[i] = 0;
end
while (l > 1)
begin
  n_remain = l % 2;
  for (j = 0; j < l >> 1; j = j + 1)
  begin
    m = n + j << 1;
    k = n + l + j + n_remain;
    ASM #(data_width) asm(clk,
      conflict[m] | conflict[m + 1],
      actives[m], actives[m + 1],
      serv_dat[m], serv_dat[m + 1],
      conflict[k],
      a_serv[k], b_serv[k],
      serv_dat[k], actives[k]);
  end
  if (n_remain > 0)
  begin
    m = n + l + 1;
    k = n + (l >> 1) + 1;
    assign actives[k] = actives[m];
    assign serv_dat[k] = serv_dat[m];
    assign conflict[k] = conflict[m];
  end
  n = n + l + n_remain;
  l = (l >> 1) + n_remain;
end
assign data_OUT = serv_dat[n_modules-1];
assign active = actives[n_modules-1];
endgenerate

endmodule
