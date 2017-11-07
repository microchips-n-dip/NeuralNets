`include "misc.v"

// Processing Element
module NodePE(clk, rst, en_v0, en_v1, compute_enable, instr, d0_IN_, d1_IN_, d_OUT);

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
output [data_width-1:0] d_OUT;

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
wire [data_width-1:0] a; // v0 out bus
wire [data_width-1:0] a1;
Reg #(data_width) v0(clk, en_v0, rst, d0_IN, a1);
Mux2 #(data_width) mux0(compute_enable, 0, a1, a);

// Operand v1
wire [data_width-1:0] b1;
Reg #(data_width) v1(clk, en_v1, rst, d1_IN, b1);
wire [data_width-1:0] b2;
Mux2 #(data_width) mux1(compute_enable, 0, b1, b2);
wire [data_width-1:0] b; // v1 out bus
Mux2 #(data_width) mux2(instr[2], b2, acc_out, b);

// Main alu
wire xc0 = a[31] ^ b[31];
wire xc1 = xc0 & ~instr[1];
wire xc2 = (instr[0] & ~instr[1] & ~xc0) | (xc0 & ~instr[0] & ~instr[1]);
wire xc3 = (a[31] & ~instr[1]) | (xc0 & instr[1]);
wire [1:0] alu_op;
assign alu_op[0] = instr[0] ^ xc1;
assign alu_op[1] = instr[1];
wire [data_width-1:0] sub0 = a - b;
wire [data_width-1:0] sub1;
Mux2 #(data_width) mux3(xc2, sub0, -sub0, sub1);
wire [data_width-1:0] f0;
Mux #(4, data_width) mux4(alu_op, {a + b, sub1, a * b, a / b}, f0);
wire sc0 = xc3 ^ acc_out[31];
wire sc1 = (xc3 & acc_out[31]) | (sc0 & ~bout);
wire [data_width-1:0] cumulate; // Enable accumulation
Mux2 #(data_width) mux5(instr[2], 0, acc_out, cumulate);
wire [data_width-1:0] sub2 = f0 - cumulate;
wire bout = cumulate > f0;
wire [data_width-1:0] sub3;
Mux2 #(data_width) mux6(sc1 & bout, sub2, -sub2, sub3);
wire [data_width-1:0] f1;
Mux2 #(data_width) mux7(sc1, f0 + cumulate, sub3, f1);
assign acc_in[30:0] = f1[30:0]; // Accumulate
assign acc_in[31] = sc1;
wire rc0 = acc_out[11] | acc_out[12];
wire rc1 = (rc0 & acc_out[13]) | (acc_out[13] & ~rc0 & acc_out[14]);
wire [14:0] rout0 = acc_out[28:14];
Mux2 #(15) mux8(instr[4], 0, rout0 + rc1, d_OUT[14:0]);
assign d_OUT[15] = acc_out[31] & instr[4];

endmodule

module NodeStripe(clk, rst, prev_enable, next_enable, ext_req, tagA_IN, tagB_IN, strideA_IN, strideB_IN, d0_IN, d1_IN, d_OUT);

parameter data_width = 16;
parameter instr_width = 7;
parameter tag_width = 12;

parameter full_width = 2 * data_width;
parameter block_width = 8 * data_width;

input clk;
input rst;
input prev_enable;
input [tag_width-1:0] tagA_IN;
input [tag_width-1:0] tagB_IN;
input [tag_width-1:0] strideA_IN;
input [tag_width-1:0] strideB_IN;
input [tag_width-1:0] iter_count_IN;
input [tag_width-1:0] iter_lim_IN;
input [block_width-1:0] d0_IN_;
input [block_width-1:0] d1_IN_;
output next_enable;
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
wire [tag_width-1:0] tag_a_1;
Mux2 #(tag_width) mux0(en_tag_write, tag_a + stride_a, tagA_IN, tag_a_1);
Reg #(tag_width) tagA(clk, en_tag_write | , rst, tag_a_1, tag_a);
wire [tag_width-1:0] stride_b;
Reg #(tag_width) strideB(clk, en_tag_write, rst, strideA_IN, stride_b);
wire [tag_width-1:0] tag_b;
wire [tag_width-1:0] tag_b_1;
Mux2 #(tag_width) mux1(en_tag_write, tag_b + stride_b, tagB_IN, tag_b_1);
Reg #(tag_width) tagB(clk, en_tag_write | , rst, tag_b_1, tag_b);

wire tm0 = tagA_IN == tag_a;
wire tm1 = tagA_IN == tag_b;
wire mm0 = tm0 | tm1;
wire ce0;
SRE lce0(clk, 0, rst1, mm0, compute_enable, ce0, );
wire tm2 = tagB_IN == tag_b;
wire tm3 = tagB_IN == tag_a;
wire mm1 = tm2 | tm3;
wire ce1;
SRE lce1(clk, 0, rst1, mm1, compute_enable, ce1, );
assign compute_enable = ce0 & ce1 & ~full_iter;

wire [block_width-1:0] d0_IN;
Mux2 #(data_width) mux2(tm1, d0_IN_, d1_IN_, d0_IN);
wire [block_width-1:0] d1_IN;
Mux2 #(data_width) mux3(tm3, d1_IN_, d0_IN_, d1_IN);

PE #(full_width, instr_width) pe0(clk, rst2, mm0, mm1, compute_enable, instr, d0_IN[15:0], d1_IN[15:0], d_OUT[15:0]);
PE #(full_width, instr_width) pe1(clk, rst2, mm0, mm1, compute_enable, instr, d0_IN[31:16], d1_IN[31:16], d_OUT[31:16]);
PE #(full_width, instr_width) pe2(clk, rst2, mm0, mm1, compute_enable, instr, d0_IN[47:32], d1_IN[47:32], d_OUT[47:32]);
PE #(full_width, instr_width) pe3(clk, rst2, mm0, mm1, compute_enable, instr, d0_IN[63:48], d1_IN[63:48], d_OUT[63:48]);
PE #(full_width, instr_width) pe4(clk, rst2, mm0, mm1, compute_enable, instr, d0_IN[79:64], d1_IN[79:64], d_OUT[79:64]);
PE #(full_width, instr_width) pe5(clk, rst2, mm0, mm1, compute_enable, instr, d0_IN[95:80], d1_IN[95:80], d_OUT[95:80]);
PE #(full_width, instr_width) pe6(clk, rst2, mm0, mm1, compute_enable, instr, d0_IN[111:96], d1_IN[111:96], d_OUT[111:96]);
PE #(full_width, instr_width) pe7(clk, rst2, mm0, mm1, compute_enable, instr, d0_IN[127:112], d1_IN[127:112], d_OUT[127:112]);

assign ext_req = en_tag_write;

endmodule

module Node(clk, rst, stream00, stream01, stream10, stream11, stream20, stream21, stream30, stream31);

parameter data_width = 16;
parameter instr_width = 7;
parameter tag_width = 16;

parameter block_width = 8 * data_width;

input clk;
input stream00;
input stream10;
input stream20;
input stream30;
output stream01;
output stream11;
output stream21;
output stream31;

wire req [0:7];
wire d_req [0:7];
wire d_serv [0:7];
wire active;
AST #(8, ) nast(clk, req, d_req, d_serv, active);

wire core_in_stream;
wire core_out_stream;

wire [] in_stream;
assign in_stream[] = stream00[];
assign in_stream[] = stream10[];
assign in_stream[] = stream20[];
assign in_stream[] = stream30[];
assign in_stream[] = core_in_stream;
wire [] out_stream;
assign out_stream[] = stream01[];
assign out_stream[] = stream11[];
assign out_stream[] = stream21[];
assign out_stream[] = stream31[];
assign out_stream[] = core_out_stream;
NodeRouter router(clk, in_stream, out_stream);

wire next_enable [0:8];
assign next_enable[0] = 1;
wire tagA;
wire tagB;
wire strideA;
wire strideB;
wire d0;
wire d1;

NodeStripe nstripe0(clk, rst, next_enable[0], next_enable[1], req[0], tagA, tagB, strideA, strideB, d0, d1);
NodeStripe nstripe1(clk, rst, next_enable[1], next_enable[2], req[1], tagA, tagB, strideA, strideB, d0, d1);
NodeStripe nstripe2(clk, rst, next_enable[2], next_enable[3], req[2], tagA, tagB, strideA, strideB, d0, d1);
NodeStripe nstripe3(clk, rst, next_enable[3], next_enable[4], req[3], tagA, tagB, strideA, strideB, d0, d1);
NodeStripe nstripe4(clk, rst, next_enable[4], next_enable[5], req[4], tagA, tagB, strideA, strideB, d0, d1);
NodeStripe nstripe5(clk, rst, next_enable[5], next_enable[6], req[5], tagA, tagB, strideA, strideB, d0, d1);
NodeStripe nstripe6(clk, rst, next_enable[6], next_enable[7], req[6], tagA, tagB, strideA, strideB, d0, d1);
NodeStripe nstripe7(clk, rst, next_enable[7], next_enable[8], req[7], tagA, tagB, strideA, strideB, d0, d1);

endmodule
