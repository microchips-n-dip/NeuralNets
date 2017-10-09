`include "misc.v"

// Line of rename table
module RenamerLine(clk, rst, input_enable, bcast_IN, A_reg, B_reg, instr_tag_IN, bcast_tag_IN, d_IN, instr_tag_OUT, tag0_OUT, d0_OUT, tag1_OUT, d1_OUT);

parameter tag_width = 8;
parameter data_width = 128;
parameter rid = 0;

input clk;
input rst;
input input_enable;
input bcast_IN;
input [3:0] A_reg;
input [3:0] B_reg;
input [tag_width-1:0] instr_tag_IN;
input [tag_width-1:0] bcast_tag_IN;
input [data_width-1:0] d_IN;
output [tag_width-1:0] instr_tag_OUT;
output [tag_width-1:0] tag0_OUT;
output [data_width-1:0] d0_OUT;
output [tag_width-1:0] tag1_OUT;
output [data_width-1:0] d1_OUT;

wire q0;
wire q0bar;

wire a_read = A_reg == rid;
wire b_read = B_reg == rid;

wire en_left_a = (a_read & input_enable) & q0;
wire en_left_b = (b_read & input_enable) & q0;
wire en_right_a = (a_read & input_enable) & q0bar;
wire en_right_b = (b_read & input_enable) & q0bar;

wire rewrite_enable;

SRE l0(clk, 0, rst, en_right_a | en_right_b, rewrite_enable, q0, q0bar);

wire [tag_width-1:0] instr_tag_mux [0:1] = {(tag_width-1){1'bz}, (tag_width-1){1'b0}};
Reg #(tag_width) instr_tag(clk, en_left_a | en_left_b, rst, instr_tag_IN, instr_tag_mux[1]);
assign tag0_OUT = instr_tag_mux[en_left_a];
assign tag1_OUT = instr_tag_mux[en_left_b];

assign rewrite_enable = (instr_tag_mux[1] == bcast_tag_IN) & bcast_IN;

wire [data_width-1:0] d_mux [0:1] = {(data_width-1){1'bz}, (data_width-1){1'b0}};
Reg #(data_width) data(clk, rewrite_enable, rst, d_IN, d_mux[1]);
assign d0_OUT = d_mux[en_right_a];
assign d1_OUT = d_mux[en_right_b];

assign instr_tag_OUT = instr_tag_IN;

endmodule

// Rename table
module RenameTable(clk, rst, input_enable, bcast_IN, A_reg, B_reg, instr_tag_IN, bcast_tag_IN, d_IN, instr_tag_OUT, tag0_OUT, d0_OUT, tag1_OUT, d1_OUT);

parameter tag_width = 8;
parameter data_width = 128;

input clk;
input rst;
input input_enable;
input bcast_IN;
input [3:0] A_reg;
input [3:0] B_reg;
input [tag_width-1:0] instr_tag_IN;
input [tag_width-1:0] bcast_tag_IN;
input [data_width-1:0] d_IN;
output [tag_width-1:0] instr_tag_OUT;
output [tag_width-1:0] tag0_OUT;
output [data_width-1:0] d0_OUT;
output [tag_width-1:0] tag1_OUT;
output [data_width-1:0] d1_OUT;

RenamerLine #(tag_width, data_width, 0) rl0(clk, rst, input_enable, bcast_IN, A_reg, B_reg, instr_tag_IN, bcast_tag_IN, d_IN, instr_tag_OUT, tag0_OUT, d0_OUT, tag1_OUT, d1_OUT);
RenamerLine #(tag_width, data_width, 1) rl0(clk, rst, input_enable, bcast_IN, A_reg, B_reg, instr_tag_IN, bcast_tag_IN, d_IN, instr_tag_OUT, tag0_OUT, d0_OUT, tag1_OUT, d1_OUT);
RenamerLine #(tag_width, data_width, 2) rl0(clk, rst, input_enable, bcast_IN, A_reg, B_reg, instr_tag_IN, bcast_tag_IN, d_IN, instr_tag_OUT, tag0_OUT, d0_OUT, tag1_OUT, d1_OUT);
RenamerLine #(tag_width, data_width, 3) rl0(clk, rst, input_enable, bcast_IN, A_reg, B_reg, instr_tag_IN, bcast_tag_IN, d_IN, instr_tag_OUT, tag0_OUT, d0_OUT, tag1_OUT, d1_OUT);
RenamerLine #(tag_width, data_width, 4) rl0(clk, rst, input_enable, bcast_IN, A_reg, B_reg, instr_tag_IN, bcast_tag_IN, d_IN, instr_tag_OUT, tag0_OUT, d0_OUT, tag1_OUT, d1_OUT);
RenamerLine #(tag_width, data_width, 5) rl0(clk, rst, input_enable, bcast_IN, A_reg, B_reg, instr_tag_IN, bcast_tag_IN, d_IN, instr_tag_OUT, tag0_OUT, d0_OUT, tag1_OUT, d1_OUT);
RenamerLine #(tag_width, data_width, 6) rl0(clk, rst, input_enable, bcast_IN, A_reg, B_reg, instr_tag_IN, bcast_tag_IN, d_IN, instr_tag_OUT, tag0_OUT, d0_OUT, tag1_OUT, d1_OUT);
RenamerLine #(tag_width, data_width, 7) rl0(clk, rst, input_enable, bcast_IN, A_reg, B_reg, instr_tag_IN, bcast_tag_IN, d_IN, instr_tag_OUT, tag0_OUT, d0_OUT, tag1_OUT, d1_OUT);
RenamerLine #(tag_width, data_width, 8) rl0(clk, rst, input_enable, bcast_IN, A_reg, B_reg, instr_tag_IN, bcast_tag_IN, d_IN, instr_tag_OUT, tag0_OUT, d0_OUT, tag1_OUT, d1_OUT);
RenamerLine #(tag_width, data_width, 9) rl0(clk, rst, input_enable, bcast_IN, A_reg, B_reg, instr_tag_IN, bcast_tag_IN, d_IN, instr_tag_OUT, tag0_OUT, d0_OUT, tag1_OUT, d1_OUT);
RenamerLine #(tag_width, data_width, 10) rl0(clk, rst, input_enable, bcast_IN, A_reg, B_reg, instr_tag_IN, bcast_tag_IN, d_IN, instr_tag_OUT, tag0_OUT, d0_OUT, tag1_OUT, d1_OUT);
RenamerLine #(tag_width, data_width, 11) rl0(clk, rst, input_enable, bcast_IN, A_reg, B_reg, instr_tag_IN, bcast_tag_IN, d_IN, instr_tag_OUT, tag0_OUT, d0_OUT, tag1_OUT, d1_OUT);
RenamerLine #(tag_width, data_width, 12) rl0(clk, rst, input_enable, bcast_IN, A_reg, B_reg, instr_tag_IN, bcast_tag_IN, d_IN, instr_tag_OUT, tag0_OUT, d0_OUT, tag1_OUT, d1_OUT);
RenamerLine #(tag_width, data_width, 13) rl0(clk, rst, input_enable, bcast_IN, A_reg, B_reg, instr_tag_IN, bcast_tag_IN, d_IN, instr_tag_OUT, tag0_OUT, d0_OUT, tag1_OUT, d1_OUT);
RenamerLine #(tag_width, data_width, 14) rl0(clk, rst, input_enable, bcast_IN, A_reg, B_reg, instr_tag_IN, bcast_tag_IN, d_IN, instr_tag_OUT, tag0_OUT, d0_OUT, tag1_OUT, d1_OUT);
RenamerLine #(tag_width, data_width, 15) rl0(clk, rst, input_enable, bcast_IN, A_reg, B_reg, instr_tag_IN, bcast_tag_IN, d_IN, instr_tag_OUT, tag0_OUT, d0_OUT, tag1_OUT, d1_OUT);

endmodule
