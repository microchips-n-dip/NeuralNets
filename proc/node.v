`include "misc.v"

// Processing Element
module NodePE(clk, rst, compute_enable, instr, d0_IN_, d1_IN_, d_OUT);

parameter data_width = 16;
parameter instr_width = 7;

parameter double_width = 32;

input clk; // Clock line
input rst; // Reset
input en_v0;
input en_v1;
input compute_enable;
input [instr_width-1:0] instr;
input [data_width-1:0] d0_IN_;
input [data_width-1:0] d1_IN_;
output [data_width-1:0] d_OUT;

// Adapt data inputs to extended internal length
wire [double_width-1:0] d0_IN;
assign d0_IN[28:14] = d0_IN_[14:0];
assign d0_IN[31] = d0_IN_[15];
wire [double_width-1:0] d1_IN;
assign d1_IN[28:14] = d1_IN_[14:0];
assign d1_IN[31] = d1_IN_[15];

// Accumulator
wire [double_width-1:0] acc_in; // Accumulator in bus
wire [double_width-1:0] acc_out; // Accumulator out bus
Reg #(double_width) acc(clk, instr[5], rst, acc_in, acc_out);

// Operand v0
wire [double_width-1:0] a; // v0 out bus
Mux2 #(double_width) mux0(compute_enable, 0, d0_IN, a);

// Operand v1
wire [double_width-1:0] b1;
Mux2 #(double_width) mux1(compute_enable, 0, d1_IN, b1);
wire [double_width-1:0] b; // v1 out bus
Mux2 #(double_width) mux2(instr[2], b1, acc_out, b);

// Main alu
wire xc0 = a[31] ^ b[31]; // Initial sign logic
wire xc1 = xc0 & ~instr[1];
wire xc2 = (instr[0] & ~instr[1] & ~xc0) | (xc0 & ~instr[0] & ~instr[1]);
wire xc3 = (a[31] & ~instr[1]) | (xc0 & instr[1]);
wire [1:0] alu_op; // ALU instruction
assign alu_op[0] = instr[0] ^ xc1; // Apply ALU_OP logic
assign alu_op[1] = instr[1];
wire [double_width-1:0] sub0 = a - b;
wire [double_width-1:0] sub1;
Mux2 #(double_width) mux3(xc2, sub0, -sub0, sub1); // Take absolute value
wire [double_width-1:0] f0; // ALU output (TODO: Separate ops into circs)
Mux #(4, double_width) mux4(alu_op, {a + b, sub1, a * b, a / b}, f0);
wire sc0 = xc3 ^ acc_out[31]; // Final sign logic
wire sc1 = (xc3 & acc_out[31]) | (sc0 & ~bout);
wire [double_width-1:0] cumulate; // Enable accumulation
Mux2 #(double_width) mux5(instr[3], 0, acc_out, cumulate);
wire [double_width-1:0] sub2 = f0 - cumulate;
wire bout = cumulate > f0;
wire [double_width-1:0] sub3;
Mux2 #(double_width) mux6(sc1 & bout, sub2, -sub2, sub3); // Take absolute value
wire [double_width-1:0] f1; // Final ALU out with accumulate
Mux2 #(double_width) mux7(sc1, f0 + cumulate, sub3, f1);
assign acc_in[30:0] = f1[30:0]; // Accumulate
assign acc_in[31] = sc1; // Final sign
wire rc0 = acc_out[11] | acc_out[12]; // Rounding logic
wire rc1 = (rc0 & acc_out[13]) | (acc_out[13] & ~rc0 & acc_out[14]);
wire [14:0] rout0 = acc_out[28:14]; // Rounded output
Mux2 #(15) mux8(instr[4], 0, rout0 + rc1, d_OUT[14:0]);
assign d_OUT[15] = acc_out[31] & instr[4]; // Output with sign

endmodule

// Stripe
module NodeStripe(clk, rst, prev_enable, next_enable, ext_req, tagA_IN, tagB_IN, strideA_IN, strideB_IN, d0_IN, d1_IN, d_OUT);

parameter data_width = 16;
parameter instr_width = 7;
parameter tag_width = 12;

parameter block_width = 8 * data_width;
parameter double_width = 2 * data_width;

input clk;
input rst;
input prev_enable;
input scalar_select_IN;
input na_select_en;
input na_select_inc_IN;
input [2:0] na_select_IN;
input [tag_width-1:0] tagA_IN;
input [tag_width-1:0] tagB_IN;
input [tag_width-1:0] strideA_IN;
input [tag_width-1:0] strideB_IN;
input [tag_width-1:0] iter_count_IN;
input [tag_width-1:0] iter_lim_IN_;
input [block_width-1:0] d0_IN_;
input [block_width-1:0] d1_IN_;
output next_enable;
output ext_req;
output [block_width-1:0] d_OUT;

wire next_enable_0;

// Switch iter_lim_IN in case of a full scalar accumulate instruction
wire [tag_width-1:0] iter_lim_IN;
Mux2 #(tag_width) ilin_switch(na_select_en, iter_lim_IN_, 8, iter_lim_IN);

wire compute_enable;
wire rst0; // Reset 0 line
wire rst1; // Reset 1 line
wire en_tag_write; // Enable tag write
wire [tag_width-1:0] iter_count; // Current iteration
Reg #(tag_width) iterCount(clk, compute_enable, rst0 | en_tag_write, iter_count_IN, iter_count);
wire [tag_width-1:0] iter_lim; // Max number of iterations
Reg #(tag_width) iterLimit(clk, en_tag_write | na_select_en, rst0, iter_lim_IN, iter_lim);
wire full_iter = iter_count == iter_lim; // Check for complete
SRE lw(clk, 0, rst1, prev_enable & en_tag_write, rst0, en_tag_write, next_enable_0);
assign rst0 = en_tag_write & full_iter; // Reset if tag write and complete
assign rst1 = rst | rst0;

// Enable next stripe in tensor core
assign next_enable = next_enable_0 & prev_enable;

wire lrrst;
SRE lr(clk, 0, rst, compute_enable, lrrst, lrrst, );
wire rst2 = lrrst | rst; // Reset 2 line

// Instruction buffer
wire [instr_width-1:0] instr;
Reg #(instr_width) instr_buf(clk, en_tag_write, rst1, instr_IN, instr);

// Tags with strides
wire [tag_width-1:0] stride_a; // Stored stride for A
Reg #(tag_width) strideA(clk, en_tag_write, rst1, strideA_IN, stride_a);
wire [tag_width-1:0] tag_a; // Stored tag for A
wire [tag_width-1:0] tag_a_1; // Incremented tag for A
Mux2 #(tag_width) mux0(en_tag_write, tag_a + stride_a, tagA_IN, tag_a_1);
Reg #(tag_width) tagA(clk, en_tag_write & ~tagA_const, rst1, tag_a_1, tag_a);
wire [tag_width-1:0] stride_b; // Stored stride for B
Reg #(tag_width) strideB(clk, en_tag_write, rst1, strideA_IN, stride_b);
wire [tag_width-1:0] tag_b; // Stored tag for B
wire [tag_width-1:0] tag_b_1; // Incremented tag for B
Mux2 #(tag_width) mux1(en_tag_write, tag_b + stride_b, tagB_IN, tag_b_1);
Reg #(tag_width) tagB(clk, en_tag_write & ~tagB_const, rst1, tag_b_1, tag_b);

// Check if there is data matching the stored tags on the common bus
wire tm0 = tagA_IN == tag_a; // Check for matching AA tags
wire tm1 = tagA_IN == tag_b; // Check for matching AB tags
wire mm0 = tm0 | tm1; // Update A register
wire ce0;
SRE lce0(clk, 0, rst1, mm0, compute_enable, ce0, );
wire tm2 = tagB_IN == tag_b; // Check for matching BB tags
wire tm3 = tagB_IN == tag_a; // Check for matching BA tags
wire mm1 = tm2 | tm3; // Update B register
wire ce1;
SRE lce1(clk, 0, rst1, mm1, compute_enable, ce1, );
assign compute_enable = ce0 & ce1 & ~full_iter;

// Data in switch (in case of tags on opposite bus)
wire [block_width-1:0] d0_IN;
Mux2 #(data_width) mux2(tm1, d0_IN_, d1_IN_, d0_IN);
wire [block_width-1:0] d1_IN;
Mux2 #(data_width) mux3(tm3, d1_IN_, d0_IN_, d1_IN);

// A and B block registers
wire [block_width-1:0] a;
Reg #(block_width) v0(clk, mm0, rst2, d0_IN, a);
wire [block_width-1:0] b;
Reg #(block_width) v1(clk, mm1, rst2, d1_IN, b);

wire scalar_select;
Reg #(1) scalar_select_flop(clk, scalar_select_IN, rst1, 1, scalar_select);
wire na_select_inc; // Increment na_select?
wire [2:0] na_select_0; // Incremented na_select
Reg #(1) na_select_inc_flop(clk, na_select_inc_IN, na_select_en | rst1, 1, na_select_inc);
Mux2 #(3) na_select_switch(na_select_en, na_select + 1, na_select_IN, na_select_0);
Reg #(3) na_select_counter(clk, na_select_en | na_select_inc, rst1, na_select_0, na_select);
wire [data_width-1:0] na; // Common scalar value to use
Mux #(3, data_width) mux4(na_select, {a[15:0], a[31:16], a[47:32], a[63:48], a[79:64], a[95:80], a[111:96], a[127:112]}, na);

// PEs
wire [data_width-1:0] pe0_a; // Switch input if A is in scalar mode
Mux2 #(data_width) mux5(scalar_select, a[15:0], na, pe0_a);
PE #(data_width, instr_width, double_width) pe0(clk, rst2, compute_enable, instr, pe0_a, b[15:0], d_OUT[15:0]);
wire [data_width-1:0] pe1_a; // Switch input if A is in scalar mode
Mux2 #(data_width) mux6(scalar_select, a[31:16], na, pe1_a);
PE #(data_width, instr_width, double_width) pe1(clk, rst2, compute_enable, instr, pe1_a, b[31:16], d_OUT[31:16]);
wire [data_width-1:0] pe0_a; // Switch input if A is in scalar mode
Mux2 #(data_width) mux7(scalar_select, a[47:32], na, pe2_a);
PE #(data_width, instr_width, double_width) pe2(clk, rst2, compute_enable, instr, pe2_a, b[47:32], d_OUT[47:32]);
wire [data_width-1:0] pe3_a; // Switch input if A is in scalar mode
Mux2 #(data_width) mux8(scalar_select, a[63:48], na, pe3_a);
PE #(data_width, instr_width, double_width) pe3(clk, rst2, compute_enable, instr, pe3_a, b[63:48], d_OUT[63:48]);
wire [data_width-1:0] pe4_a; // Switch input if A is in scalar mode
Mux2 #(data_width) mux9(scalar_select, a[79:64], na, pe4_a);
PE #(data_width, instr_width, double_width) pe4(clk, rst2, compute_enable, instr, pe4_a, b[79:64], d_OUT[79:64]);
wire [data_width-1:0] pe5_a; // Switch input if A is in scalar mode
Mux2 #(data_width) mux10(scalar_select, a[95:80], na, pe5_a);
PE #(data_width, instr_width, double_width) pe5(clk, rst2, compute_enable, instr, pe5_a, b[95:80], d_OUT[95:80]);
wire [data_width-1:0] pe6_a; // Switch input if A is in scalar mode
Mux2 #(data_width) mux11(scalar_select, a[111:96], na, pe6_a);
PE #(data_width, instr_width, double_width) pe6(clk, rst2, compute_enable, instr, pe6_a, b[111:96], d_OUT[111:96]);
wire [data_width-1:0] pe7_a; // Switch input if A is in scalar mode
Mux2 #(data_width) mux12(scalar_select, a[127:112], na, pe7_a);
PE #(data_width, instr_width, double_width) pe7(clk, rst2, compute_enable, instr, pe7_a, b[127:112], d_OUT[127:112]);

assign ext_req = instr[4]; // If we're returning a number

endmodule

// Tensor core
module NodeTensorCore(clk, rst, ext_req, tagA, tagB, strideA, strideB, d0, d1, d_OUT);

parameter data_width = 16;
parameter instr_width = 7;
parameter tag_width = 16;

parameter block_width = 8 * data_width;

input clk;
input rst;
input [tag_width-1:0] tagA;
input [tag_width-1:0] tagB;
input [tag_width-1:0] strideA;
input [tag_width-1:0] strideB;
input [block_width-1:0] d0;
input [block_width-1:0] d1;
output ext_req;
output [block_width-1:0] d_OUT;

// AST switch for handling return instructions
wire req [0:7];
wire [block_width-1:0] d_req [0:7];
AST #(8, block_width) nast(clk, req, d_req, d_OUT, ext_req);

wire next_enable [0:8];
assign next_enable[0] = 1;

// Stripes
NodeStripe #(data_width, instr_width, block_width) \
  nstripe0(clk, rst, next_enable[0], next_enable[1], req[0], tagA, tagB, strideA, strideB, d0, d1, d_req[0]);
NodeStripe #(data_width, instr_width, block_width) \
  nstripe1(clk, rst, next_enable[1], next_enable[2], req[1], tagA, tagB, strideA, strideB, d0, d1, d_req[1]);
NodeStripe #(data_width, instr_width, block_width) \
  nstripe2(clk, rst, next_enable[2], next_enable[3], req[2], tagA, tagB, strideA, strideB, d0, d1, d_req[2]);
NodeStripe #(data_width, instr_width, block_width) \
  nstripe3(clk, rst, next_enable[3], next_enable[4], req[3], tagA, tagB, strideA, strideB, d0, d1, d_req[3]);
NodeStripe #(data_width, instr_width, block_width) \
  nstripe4(clk, rst, next_enable[4], next_enable[5], req[4], tagA, tagB, strideA, strideB, d0, d1, d_req[4]);
NodeStripe #(data_width, instr_width, block_width) \
  nstripe5(clk, rst, next_enable[5], next_enable[6], req[5], tagA, tagB, strideA, strideB, d0, d1, d_req[5]);
NodeStripe #(data_width, instr_width, block_width) \
  nstripe6(clk, rst, next_enable[6], next_enable[7], req[6], tagA, tagB, strideA, strideB, d0, d1, d_req[6]);
NodeStripe #(data_width, instr_width, block_width) \
  nstripe7(clk, rst, next_enable[7], next_enable[8], req[7], tagA, tagB, strideA, strideB, d0, d1, d_req[7]);

endmodule

// Full node
module Node(clk, rst);

parameter data_width = 16;
parameter instr_width = 7;
parameter tag_width = 16;

parameter net_width = 4;

parameter block_width = 8 * data_width;
parameter stream_width = block_width + net_width;

input clk;
input rst;

// I/O streams
input [stream_width-1:0] stream00;
input [stream_width-1:0] stream10;
input [stream_width-1:0] stream20;
input [stream_width-1:0] stream30;
output [stream_width-1:0] stream01;
output [stream_width-1:0] stream11;
output [stream_width-1:0] stream21;
output [stream_width-1:0] stream31;

// CPU I/O streams
wire [stream_width-1:0] core_in_stream;
wire [stream_width-1:0] core_out_stream;

// Router for handling data requests
wire [stream_width-1:0] in_stream [0:4];
assign in_stream[0] = stream00;
assign in_stream[1] = stream10;
assign in_stream[2] = stream20;
assign in_stream[3] = stream30;
assign in_stream[4] = core_in_stream;
wire [stream_width-1:0] out_stream [0:4];
assign out_stream[0] = stream01;
assign out_stream[1] = stream11;
assign out_stream[2] = stream21;
assign out_stream[3] = stream31;
assign out_stream[4] = core_out_stream;
NodeRouter router(clk, in_stream, out_stream);

// TODO: Add CPU and remove these "commons"
wire [tag_width-1:0] working_tag;
wire [tag_width-1:0] working_stride;
wire [block_width-1:0] common_bus;

// AST switch for handling return instructions
wire actives [0:7];
wire active;
wire [block_width-1:0] bus_in [0:7];
wire [block_width-1:0] bus_out;
AST #(8, block_width) nast0(clk, actives, bus_in, bus_out, active);

// Tensor cores
NodeTensorCore #(data_width, instr_width, tag_width, block_width) \
  ntc0(clk, rst, actives[0], working_tag, working_tag, working_stride, working_stride, common_bus, common_bus, bus_in[0]);
NodeTensorCore #(data_width, instr_width, tag_width, block_width) \
  ntc1(clk, rst, actives[1], working_tag, working_tag, working_stride, working_stride, common_bus, common_bus, bus_in[1]);
NodeTensorCore #(data_width, instr_width, tag_width, block_width) \
  ntc2(clk, rst, actives[2], working_tag, working_tag, working_stride, working_stride, common_bus, common_bus, bus_in[2]);
NodeTensorCore #(data_width, instr_width, tag_width, block_width) \
  ntc3(clk, rst, actives[3], working_tag, working_tag, working_stride, working_stride, common_bus, common_bus, bus_in[3]);
NodeTensorCore #(data_width, instr_width, tag_width, block_width) \
  ntc4(clk, rst, actives[4], working_tag, working_tag, working_stride, working_stride, common_bus, common_bus, bus_in[4]);
NodeTensorCore #(data_width, instr_width, tag_width, block_width) \
  ntc5(clk, rst, actives[5], working_tag, working_tag, working_stride, working_stride, common_bus, common_bus, bus_in[5]);
NodeTensorCore #(data_width, instr_width, tag_width, block_width) \
  ntc6(clk, rst, actives[6], working_tag, working_tag, working_stride, working_stride, common_bus, common_bus, bus_in[6]);
NodeTensorCore #(data_width, instr_width, tag_width, block_width) \
  ntc7(clk, rst, actives[7], working_tag, working_tag, working_stride, working_stride, common_bus, common_bus, bus_in[7]);

endmodule
