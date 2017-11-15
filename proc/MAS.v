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

/*
// Access scheduler tree servicing four inputs (inputs to be revised to resemble AST_6)  
module AST_4(clk, core_1_req, core_2_req, core_3_req, core_4_req, core_1_addr, core_2_addr, core_3_addr, core_4_addr, core_1_serv, core_2_serv, core_3_serv, core_4_serv, active, data_OUT);

input clk; // Clock line
input core_1_req; // Input 1 requesting
input core_2_req; // Input 2 requesting
input core_3_req; // Input 3 requesting
input core_4_req; // Input 4 requesting
input [5:0] core_1_addr; // Input 1 requested address
input [5:0] core_2_addr; // Input 2 requested address
input [5:0] core_3_addr; // Input 3 requested address
input [5:0] core_4_addr; // Input 4 requested address
output core_1_serv; // Servicing request 1
output core_2_serv; // Servicing request 2
output core_3_serv; // Servicing request 3
output core_4_serv; // Servicing request 4
output active; // Active flag
output [5:0] data_OUT; // Servicing address

wire active_c12; // Module on inputs 1 & 2 active flag
wire conflict_c12; // Module on inputs 1 & 2 conflict flag
wire serv_c12_a; // Servicing input A
wire serv_c12_b; // Servicing input B
wire [6:0] o_c12_addr; // Outputted address
ASM c12(clk, 0, core_1_req, core_2_req, core_1_addr, core_2_addr, conflict_c12, serv_c12_a, serv_c12_b, o_c12_addr, active_c12);

wire active_c34; // Module on inputs 3 & 4 active flag
wire conflict_c34; // Module on inputs 3 & 4 conflict flag
wire serv_c34_a; // Servicing input A
wire serv_c34_b; // Servicing input B
wire [6:0] o_c34_addr; // Outputted address
ASM c34(clk, 0, core_3_req, core_4_req, core_3_addr, core_4_addr, conflict_c34, serv_c34_a, serv_c34_b, o_c34_addr, active_c34);

// Inner module
wire any_conflict = conflict_c12 || conflict_c34; // Determine any conflicts on the previous layer
wire serv_inner_1; // Servicing module 1 & 2
wire serv_inner_2; // Servicing module 3 & 4
ASM c_inner(clk, any_conflict, active_c12, active_c34, o_c12_addr, o_c34_addr, serv_inner_1, serv_inner_2, data_OUT, active);

// Determine which input is being serviced
assign core_1_serv = serv_c12_a && serv_inner_1;
assign core_2_serv = serv_c12_b && serv_inner_1;
assign core_3_serv = serv_c34_a && serv_inner_2;
assign core_4_serv = serv_c34_b && serv_inner_2;

endmodule
*/

module AST_5(clk, req, data_IN, data_OUT);

parameter data_width = 132;

input clk;
input req [0:4];
input [data_width-1:0] data_IN [0:4];
output [data_width-1:0] data_OUT;

wire conflict [0:3];
wire a_serv [0:3];
wire b_serv [0:3];
wire serv_dat [0:3];
wire actives [0:3];

ASM #(data_width) asm0(clk, 0, req[0], req[1], data_IN[0], data_IN[1], conflict[0], a_serv[0], b_serv[0], serv_dat[0], actives[0]);
ASM #(data_width) asm1(clk, 0, req[2], req[3], data_IN[2], data_IN[3], conflict[1], a_serv[1], b_serv[1], serv_dat[1], actives[1]);
ASM #(data_width) asm4(clk, conflict[0] | conflict[1], actives[0], actives[1], serv_dat[2], serv_dat[2], conflict[2], a_serv[2], b_serv[2], serv_dat[2], actives[2]);
ASM #(data_width) asm5(clk, conflict[2], actives[2], req[4], serv_dat[3], data_IN[4], conflict[3], a_serv[3], b_serv[3], serv_dat[3], actives[3]);

/*
assign serv[0] = a_serv[0] & a_serv[2] & a_serv[3];
assign serv[1] = b_serv[0] & a_serv[2] & a_serv[3];
assign serv[2] = a_serv[1] & b_serv[2] & a_serv[3];
assign serv[3] = b_serv[1] & b_serv[2] & a_serv[3];
assign serv[4] = b_serv[3];
*/

assign data_OUT = serv_dat[3];

//assign active = actives[3];

endmodule

/*
// I think you get the idea
// TODO: rename these "core" inputs, there's a differenct setup now on the interconnect
module AST_6(clk, core_req, core_addr, core_serv, active, data_OUT);

input clk;
input core_req [0:5];
input [5:0] core_addr [0:5];
output core_serv [0:5];
output active;
output [5:0] data_OUT;

wire active_c12;
wire cc12;
wire serv_c12_a;
wire serv_c12_b;
wire [5:0] o_c12_addr;
ASM c12(clk, 0, core_req[0], core_req[1], core_addr[0], core_addr[1], cc12, serv_c12_a, serv_c12_b, o_c12_addr, active_c12);

wire active_c34;
wire cc34;
wire serv_c34_a;
wire serv_c34_b;
wire [5:0] o_c34_addr;
ASM c34(clk, 0, core_req[2], core_req[3], core_addr[2], core_addr[3], cc34, serv_c34_a, serv_c34_b, o_c34_addr, active_c34);

wire active_c56;
wire cc56;
wire serv_c56_a;
wire serv_c56_b;
wire [5:0] o_c56_addr;
ASM c56(clk, 0, core_req[4], core_req[5], core_addr[4], core_addr[5], cc56, serv_c56_a, serv_c56_b, o_c56_addr, active_c56);

wire active_inner_1;
wire c_inner_1;
wire serv_inner_1;
wire serv_inner_2;
wire [5:0] o_c_inner_1;
ASM c_inner_1(clk, cc12 || cc34, active_c12, active_c34, o_c12_addr, o_c34_addr, c_inner_1, serv_inner_1, serv_inner_2, o_c_inner_1, active_inner_1);

wire active_inner_2;
wire c_inner_2;
wire serv_inner_3;
wire serv_inner_4;
wire [5:0] o_c_inner_2;
ASM c_inner_2(clk, c_inner_1 || cc56, active_inner_1, active_c56, o_c_inner_1, o_c56_addr, c_inner_2, serv_inner_3, serv_inner_4, o_c_inner_2, active_inner_2);

assign core_serv[0] = serv_c12_a && serv_inner_1 && serv_inner_3;
assign core_serv[1] = serv_c12_b && serv_inner_1 && serv_inner_3;
assign core_serv[2] = serv_c34_a && serv_inner_2 && serv_inner_3;
assign core_serv[3] = serv_c34_b && serv_inner_2 && serv_inner_3;
assign core_serv[4] = serv_c56_a && serv_inner_4;
assign core_serv[5] = serv_c56_b && serv_inner_4;

assign data_OUT = o_c_inner_2;

endmodule
*/

module AST_8(clk, req, data_IN, data_OUT);

parameter data_width = 132;

input clk;
input req [0:7];
input [data_width-1:0] data_IN [0:7];
output [data_width-1:0] data_OUT [0:7];

wire conflict [0:6];
wire a_serv [0:6];
wire b_serv [0:6];
wire serv_dat [0:6];
wire actives [0:6];

ASM #(data_width) asm0(clk, 0, req[0], req[1], data_IN[0], data_IN[1], conflict[0], a_serv[0], b_serv[0], serv_dat[0], actives[0]);
ASM #(data_width) asm1(clk, 0, req[2], req[3], data_IN[2], data_IN[3], conflict[1], a_serv[1], b_serv[1], serv_dat[1], actives[1]);
ASM #(data_width) asm2(clk, 0, req[4], req[5], data_IN[4], data_IN[5], conflict[2], a_serv[2], b_serv[2], serv_dat[2], actives[2]);
ASM #(data_width) asm3(clk, 0, req[6], req[7], data_IN[6], data_IN[7], conflict[3], a_serv[3], b_serv[3], serv_dat[3], actives[3]);
ASM #(data_width) asm4(clk, conflict[0] | conflict[1], actives[0], actives[1], serv_dat[0], serv_dat[1], conflict[4], a_serv[4], b_serv[4], serv_dat[4], actives[4]);
ASM #(data_width) asm5(clk, conflict[2] | conflict[3], actives[2], actives[3], serv_dat[2], serv_dat[3], conflict[5], a_serv[5], b_serv[5], serv_dat[5], actives[5]);
ASM #(data_width) asm6(clk, conflict[4] | conflict[5], actives[4], actives[5], serv_dat[4], serv_dat[5], conflict[6], a_serv[6], b_serv[6], serv_dat[6], actives[6]);

/*
assign serv[0] = a_serv[0] & a_serv[4] & a_serv[6];
assign serv[1] = b_serv[0] & a_serv[4] & a_serv[6];
assign serv[2] = a_serv[1] & b_serv[4] & a_serv[6];
assign serv[3] = b_serv[1] & b_serv[4] & a_serv[6];
assign serv[4] = a_serv[2] & a_serv[5] & b_serv[6];
assign serv[5] = b_serv[2] & a_serv[5] & b_serv[6];
assign serv[6] = a_serv[3] & b_serv[5] & b_serv[6];
assign serv[7] = b_serv[3] & b_serv[5] & b_serv[6];
*/

assign data_OUT = serv_dat[6];

//assign active = actives[6];

endmodule


module AST(clk, req, d_IN, d_OUT, active);

parameter switch_bits = 3;
parameter data_width = 132;

parameter tree0 = pow(2, switch_bits);
parameter tree1 = pow(2, switch_bits + 1) - 1;

input clk;
input req [0:tree0-1];
input [data_width-1:0] d_IN [0:tree0-1];
output [data_width-1:0] d_OUT;
output active;

wire conflict [0:tree1];
wire a_serv [0:tree1];
wire b_serv [0:tree1];
wire [data_width-1:0] serv_dat [0:tree1];
wire actives [0:tree1];

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
  assign actives[i] = req[i];
  assign serv_dat[i] = d_IN[i];
  assign conflict[i] = 0;
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
    ASM #(data_width) asm(clk, conflict[m] | conflict[m + 1], actives[m], actives[m + 1], serv_dat[m], serv_dat[m + 1], conflict[k], a_serv[k], b_serv[k], serv_dat[k], actives[k]);
  end
  l = 2 * l;
end
endgenerate

assign d_OUT = serv_dat[n_mod-1];
assign active = actives[n_mod-1];

endmodule
