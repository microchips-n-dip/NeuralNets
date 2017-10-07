module Reg(clk, en, rst, data_IN, data_OUT)

parameter width = 8;

input clk;
input en;
input rst;
input [width-1:0] data_IN;
output [width-1:0] data_OUT;

reg [width-1:0] data;

always @(en and posedge clk)
begin
  data <= data_IN;
end

always @(rst)
begin
  data <= (width-1){1b'0};
end

assign data_OUT = data;

endmodule

module TEntryHalf(clk, rst, tag_IN, data_IN, data_OUT, prevalid_IN, valid_OUT, rta_IN, rta_enable, rtb_IN, rtb_enable, rtamatch_OUT, rtbmatch_OUT, read_enable, write, enable);

parameter tag_width = 8;
parameter data_width = 128;

input clk;
input rst;
input [tag_width-1:0] tag_IN;
input [data_width-1:0] data_IN;
input prevalid_IN;
input read_enable;
input write;
input enable;
input rta_IN;
input rta_enable;
input rtb_IN;
input rtb_enable;
output [data_width-1:0] data_OUT;
output valid_OUT;
output rtamatch_OUT;
output rtbmatch_OUT;

wire tags_eq;
wire unit_enable = (tags_eq & enable) | write;
wire v_enable = prevalid_IN | tags_eq;

wire [data_width-1:0] data_mux [0:1] = {0, 0};

wire [tag_width-1:0] tag_output;
Reg #(tag_width) tag(clk, unit_enable, rst, tag_IN, tag_output);
Reg #(data_width) data(clk, unit_enable, rst, data_IN, data_mux[1]);
Reg #(1) valid(clk, v_enable, 0, unit_enable, valid_OUT);

EQ(tag_IN, tag_output, tags_eq);

wire rta_eq;
EQ(rta_IN, tag_output, rta_eq);
assign rtamatch_OUT = rta_eq & rta_enable;
wire rtb_eq;
EQ(rtb_IN, tag_output, rtb_eq);
assign rtbmatch_OUT = rtb_eq & rtb_enable;

assign data_OUT = data_mux[rta_enable | rtb_enable | read_enable];

endmodule

module TEntry(clk, rst, read_enable, write_alloc, bcast_IN, acache_hit, bcache_hit, lookup, ready, rtamatch, rtbmatch, instr_IN, instr_OUT, wb_tag_IN, wb_tag_OUT, write_tag_IN, tag0_IN, d0_IN, d0_OUT, tag1_IN, d1_IN, d1_OUT);

parameter instr_width = 16;
parameter tag_width = 8;
parameter data_width = 128;

input clk;
input rst;
input read_enable;
input write_alloc;
input bcast_IN;
input acache_hit;
input bcache_hit;
input lookup;
input [instr_width-1:0] instr_IN;
input [tag_width-1:0] wb_tag_IN;
input [tag_width-1:0] write_tag_IN;
input [tag_width-1:0] tag0_IN;
input d0_IN;
input [tag_width-1:0] tag1_IN;
input d1_IN;
output ready;
output rtamatch;
output rtbmatch;
output [instr_width-1:0] instr_OUT;
output [tag_width-1:0] wb_tag_OUT;
output d0_OUT;
output d1_OUT;

wire [instr_width-1:0] instr_mux [0:1] = {0, 0};
Reg #(instr_width) instr(clk, write_alloc, rst, instr_IN, instr_mux[1]);
wire [tag_width-1:0] wb_tag_mux [0:1] = {0, 0};
Reg #(tag_width) wb_tag(clk, write_alloc, rst, wb_tag_IN, wb_tag_mux[1]);

wire valid0;
wire rta0;
wire rtb0;
TEntryHalf #(tag_width, data_width) entry_a(clk, rst, write_tag_IN, d0_IN, d0_OUT, acache_hit, valid0, tag0_IN, lookup, tag1_IN, lookup, rta0, rtb0, write_alloc, bcast_IN);
wire valid1;
wire rta1;
wire rtb1;
TEntryHalf #(tag_width, data_width) entry_b(clk, rst, write_tag_IN, d1_IN, d1_OUT, acache_hit, valid1, tag0_IN, lookup, tag1_IN, lookup, rta1, rtb1, write_alloc, bcast_IN);

assign instr_OUT = instr_mux[read_enable];
assign wb_tag_OUT = wb_tag_mux[read_enable];

assign ready = valid0 & valid1;
assign rtamatch = rta0 | rta1;
assign rtbmatch = rtb0 | rtb1;

endmodule
