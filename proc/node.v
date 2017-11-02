`include "misc.v"

// Processing Element
module PE(clk, rst, en_v0, en_v1, compute_enable, instr, d0_IN_, d1_IN_);

parameter data_width = 32;
parameter instr_width = 7;

input clk; // Clock line
input rst; // Reset
input en_v0;
input en_v1;
input compute_enable;
input [instr_width-1:0] instr;
input [data_width-1:0] d0_IN_;
input [data_width-1:0] d1_IN_;

wire [data_width-1:0] d0_IN;
assign d0_IN[28:14] = d0_IN_[14:0];
assign d0_IN[31] = d0_IN_[15];
wire [data_width-1:0] d1_IN;
assign d1_IN[28:14] = d1_IN_[14:0];
assign d1_IN[31] = d1_IN_[15];

// Accumulator
wire [data_width-1:0] acc_in; // Accumulator in bus
wire [data_width-1:0] acc_out; // Accumulator out bus
Reg #(data_width) acc(clk, instr[5], rst, acc_in, acc_out);

// Operand v0
wire [data_width-1:0] a_on_mux [0:1];
assign a_on_mux[0] = 0;
wire [data_width-1:0] a; // v0 out bus
Reg #(data_width) v0(clk, en_v0, rst, d0_IN, a_on_mux[1]);
assign a = a_on_mux[compute_enable];

// Operand v1
wire [data_width-1:0] b_on_mux[0:1]
wire [data_width-1:0] b_mux [0:1]; // Mux to switch from b to acc
assign b_on_mux[0] = 0;
Reg #(data_width) v1(clk, en_v1, rst, d1_IN, b_on_mux[1]);
assign b_mux[0] = b_on_mux[compute_enable];
assign b_mux[1] = acc_out;
wire [data_width-1:0] b = b_mux[instr[2]]; // v1 out bus

// Main alu
wire xc0 = a[31] ^ b[31];
wire xc1 = xc0 & ~instr[1];
wire xc2 = (instr[0] & ~instr[1] & ~xc0) | (xc0 & ~instr[0] & ~instr[1]);
wire xc3 = (a[31] & ~instr[1]) | (xc0 & instr[1]);
wire [1:0] alu_op;
assign alu_op[0] = instr[0] ^ xc1;
assign alu_op[1] = instr[1];
wire [data_width-1:0] sub0 = a - b;
wire [data_width-1:0] sub0_mux [0:1] = {sub0, -sub0};
wire [data_width-1:0] f0_mux [0:3] = {a + b, sub0_mux[xc2], a * b, a / b}; // TBD
wire [data_width-1:0] f0 = f0_mux[alu_op];
wire sc0 = xc3 ^ acc_out[31];
wire sc1 = (xc3 & acc_out[31]) | (sc0 & ~bout);
wire [data_width-1:0] cumulate_mux [0:1] = {0, acc_out};
wire [data_width-1:0] cumulate = cumulate_mux[instr[2]]; // Enable accumulation
wire [data_width-1:0] sub1 = f0 - cumulate;
wire bout = cumulate > f0;
wire [data_width-1:0] sub1_mux [0:1] = {sub1, -sub1};
wire [data_width-1:0] f1_mux [0:1] = {f0 + cumulate, sub1_mux[sc1 & bout]};
assign acc_in[30:0] = f1_mux[sc1][30:0]; // Accumulate
assign acc_in[31] = sc1;
wire rc0 = acc_out[11] | acc_out[12];
wire rc1 = (rc0 & acc_out[13]) | (acc_out[13] & ~rc0 & acc_out[14]);


endmodule

module Stripe(clk, rst, tag_IN, stride_IN, d0_IN, d1_IN, d_OUT);

parameter data_width = 32;
parameter block_width = 128;
parameter instr_width = 7;
parameter tag_width = 12;

input clk;
input rst;
input [tag_width-1:0] tagA_IN;
input [tag_width-1:0] tagB_IN;
input [tag_width-1:0] strideA_IN;
input [tag_width-1:0] strideB_IN;
input [tag_width-1:0] iter_count_IN;
input [tag_width-1:0] iter_lim_IN;
input [block_width-1:0] d0_IN;
input [block_width-1:0] d1_IN;
output [block_width-1:0] d_OUT;

wire next_enable_0;

wire compute_enable;
wire rst0;
wire rst1;
wire en_tag_write;
wire [tag_width-1:0] iter_count;
Reg #(tag_width) iterCount(clk, compute_enable, rst0 | en_tag_write, iter_count_IN, iter_count);
wire [tag_width-1:0] iter_lim;
Reg #(tag_width) iterLimit(clk, en_tag_write, rst0, iter_lim_IN, iter_lim);
wire full_iter = iter_count == iter_lim;
SRE lw(clk, 0, rst1, prev_enable & en_tag_write, rst0, en_tag_write, next_enable_0);
assign rst0 = en_tag_write & full_iter;
assign rst1 = rst | rst0;

assign next_enable = next_enable_0 & prev_enable;

wire lrrst;
SRE lr(clk, 0, rst, compute_enable, lrrst, lrrst, );
wire rst2 = lrrst | rst;

wire [instr_width-1:0] instr;
Reg #(instr_width) instr_buf(clk, en_tag_write, rst, instr_IN, instr);

wire [tag_width-1:0] stride_a;
Reg #(tag_width) strideA(clk, en_tag_write, rst, strideA_IN, stride_a);
wire [tag_width-1:0] tag_a;
wire [tag_width-1:0] tag_a_mux [0:1] = {tag_a + stride_a, tagA_IN};
Reg #(tag_width) tagA(clk, en_tag_write | , rst, tag_a_mux[en_tag_write], tag_a);
wire [tag_width-1:0] stride_b;
Reg #(tag_width) strideB(clk, en_tag_write, rst, strideA_IN, stride_b);
wire [tag_width-1:0] tag_b;
wire [tag_width-1:0] tag_b_mux [0:1] = {tag_b + stride_b, tagB_IN};
Reg #(tag_width) tagB(clk, en_tag_write | , rst, tag_b_mux[en_tag_write], tag_b);

wire tm0 = tagA_IN == tag_a;
wire tm1 = tagA_IN == tag_b;
wire mm0 = tm0 | tm1;
wire ce0;
SRE lce0(clk, 0, rst1, mm0, compute_enable, ce0, );
wire tm3 = tagB_IN == tag_a;
wire tm2 = tagB_IN == tag_b;
wire mm1 = tm2 | tm3;
wire ce1;
SRE lce1(clk, 0, rst1, mm1, compute_enable, ce1, );
assign compute_enable = ce0 & ce1 & ~full_iter;

PE #(data_width, instr_width) pe0(clk, rst2, mm0, mm1, compute_enable, instr, d0_IN[15:0], d1_IN[15:0], d_OUT[15:0]);
PE #(data_width, instr_width) pe1(clk, rst2, mm0, mm1, compute_enable, instr, d0_IN[31:16], d1_IN[31:16], d_OUT[31:16]);
PE #(data_width, instr_width) pe2(clk, rst2, mm0, mm1, compute_enable, instr, d0_IN[47:32], d1_IN[47:32], d_OUT[47:32]);
PE #(data_width, instr_width) pe3(clk, rst2, mm0, mm1, compute_enable, instr, d0_IN[63:48], d1_IN[63:48], d_OUT[63:48]);
PE #(data_width, instr_width) pe4(clk, rst2, mm0, mm1, compute_enable, instr, d0_IN[79:64], d1_IN[79:64], d_OUT[79:64]);
PE #(data_width, instr_width) pe5(clk, rst2, mm0, mm1, compute_enable, instr, d0_IN[95:80], d1_IN[95:80], d_OUT[95:80]);
PE #(data_width, instr_width) pe6(clk, rst2, mm0, mm1, compute_enable, instr, d0_IN[111:96], d1_IN[111:96], d_OUT[111:96]);
PE #(data_width, instr_width) pe7(clk, rst2, mm0, mm1, compute_enable, instr, d0_IN[127:112], d1_IN[127:112], d_OUT[127:112]);

endmodule
