// Half entry for reservation station
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

wire [data_width-1:0] data_mux [0:1] = {(data_width-1){1'bz}, (data_width-1){1'b0}};

wire [tag_width-1:0] tag_output;
Reg #(tag_width) tag(clk, write, rst, tag_IN, tag_output);
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

// Full entry for reservation station
module TEntry(clk, rst, read_enable, write_alloc, bcast_IN, acache_hit, bcache_hit, lookup, ready, rtamatch_a, rtbmatch_a, rtamatch_b, rtbmatch_b, instr_IN, instr_OUT, wb_tag_IN, wb_tag_OUT, tag0_IN, d0_IN, d0_OUT, tag1_IN, d1_IN, d1_OUT);

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
input [tag_width-1:0] tag0_IN;
input d0_IN;
input [tag_width-1:0] tag1_IN;
input d1_IN;
output ready;
output rtamatch_a;
output rtbmatch_a;
output rtamatch_b;
output rtbmatch_b;
output [instr_width-1:0] instr_OUT;
output [tag_width-1:0] wb_tag_OUT;
output d0_OUT;
output d1_OUT;

wire [instr_width-1:0] instr_mux [0:1] = {(data_width-1){1'bz}, (data_width-1){1'b0}};
Reg #(instr_width) instr(clk, write_alloc, rst, instr_IN, instr_mux[1]);
wire [tag_width-1:0] wb_tag_mux [0:1] = {(tag_width-1){1'bz}, (tag_width-1){1'b0}};
Reg #(tag_width) wb_tag(clk, write_alloc, rst, wb_tag_IN, wb_tag_mux[1]);

wire valid0;
wire rta0;
wire rtb0;
TEntryHalf #(tag_width, data_width) entry_a(clk, rst, tag0_IN, d0_IN, d0_OUT, acache_hit, valid0, tag0_IN, lookup, tag1_IN, lookup, rta0, rtb0, write_alloc, bcast_IN);
wire valid1;
wire rta1;
wire rtb1;
TEntryHalf #(tag_width, data_width) entry_b(clk, rst, tag1_IN, d1_IN, d1_OUT, acache_hit, valid1, tag0_IN, lookup, tag1_IN, lookup, rta1, rtb1, write_alloc, bcast_IN);

assign instr_OUT = instr_mux[read_enable];
assign wb_tag_OUT = wb_tag_mux[read_enable];

assign ready = valid0 & valid1;
assign rtamatch_a = rta0;
assign rtbmatch_a = rtb0;
assign rtbmatch_b = rta1;
assign rtbmatch_b = rtb1;

endmodule

// Entry with bussing
module TEntryBus(clk, rst, prev_enable, next_enable, bcast_IN, write_entry, acache_hit, bcache_hit, match_bus, instr_tag_bus, instr_IN, instr_tag_IN, tag0_IN, tag1_IN, d0_IN, d1_IN, instr_OUT, d0_OUT, d1_OUT);

parameter instr_width = 16;
parameter tag_width = 8;
parameter data_width = 128;
parameter entry = 0;
parameter non_entry_0 = (entry + 1) % 4;
parameter non_entry_1 = (entry + 2) % 4;
parameter non_entry_2 = (entry + 3) % 4;

input clk;
input rst;
input prev_enable;
input bcast_IN;
input write_entry;
input acache_hit;
input bcache_hit;
input [instr_width-1:0] instr_IN;
input [tag_width-1:0] instr_tag_IN;
input [tag_width-1:0] tag0_IN;
input [tag_width-1:0] tag1_IN;
inout match_bus [0:3];
inout [tag_width-1:0] instr_tag_bus [0:3];
inout [data_width-1:0] d0_IN;
inout [data_width-1:0] d1_IN;
output next_enable;
output [instr_width-1:0] instr_OUT;
output [data_width-1:0] d0_OUT;
output [data_width-1:0] d1_OUT;

wire lt0;
cmpl cl0(entry, instr_tag_bus[non_entry_0], lt0);
wire lt1;
cmpl cl1(entry, instr_tag_bus[non_entry_1], lt1);
wire lt2;
cmpl cl2(entry, instr_tag_bus[non_entry_2], lt2);
wire ready;
wire read_enable = ready & lt0 & lt1 & lt2;

wire r0out;
Reg #(1) r0(clk, rst | read_enable, bcast_IN, rst | read_enable, r0out);
wire write_enable;
wire r1out;
Reg #(1) r1(clk, write_enable, rst, write_enable, r1out);
wire l0q;
wire l0qbar;
SR l0(r1out, r0out, l0q, l0qbar);
assign write_enable = l0qbar & prev_enable;
assign next_enable = l0q & prev_enable;

wire broadcast = bcast_IN | match_bus[non_entry_0] | match_bus[non_entry_1] | match_bus[non_entry_2];
wire lookup = write_entry & ~write_enable;
wire rtamatch_a;
wire rtbmatch_a;
wire rtamatch_b;
wire rtbmatch_b;
TEntry #(instr_width, tag_width, data_width) entry0(clk, rst, read_enable, write_enable, broadcast, acache_hit, bcache_hit, lookup, ready, rtamatch_a, rtamatch_b, rtbmatch_a, rtbmatch_b, instr_IN, instr_OUT, instr_tag_IN, instr_tag_bus[entry], tag0_IN, d0_IN, d0_OUT, tag1_IN, d1_IN, d1_OUT);
assign match_bus[entry] = rtamatch_a | rtbmatch_a | rtamatch_b | rtbmatch_b;
assign d0_IN = d0_OUT;
assign d1_IN = d1_OUT;

endmodule

// Reservation station
module TRS4(clk, rst, bcast_IN, write_entry, acache_hit, bcache_hit, instr_IN, instr_tag_IN, tag0_IN, tag1_IN, d0_IN, d1_IN, instr_OUT, instr_tag_OUT, d0_OUT, d1_OUT);

parameter instr_width = 16;
parameter tag_width = 8;
parameter data_width = 128;

input clk;
input rst;
input bcast_IN;
input write_entry;
input acache_hit;
input bcache_hit;
input [instr_width-1:0] instr_IN;
input [tag_width-1:0] instr_tag_IN;
input [tag_width-1:0] tag0_IN;
input [tag_width-1:0] tag1_IN;
input [data_width-1:0] d0_IN;
input [data_width-1:0] d1_IN;
output [instr_width-1:0] instr_OUT;
output [tag_width-1:0] instr_tag_OUT;
output [data_width-1:0] d0_OUT;
output [data_width-1:0] d1_OUT;

wire match_bus [0:3];
wire read_switch[0:4] = {bcast_IN, 1'b0, 1'b0, 1'b0, 1'b0};
wire [tag_width-1:0] instr_tag_bus [0:3];

TEntryBus #(instr_width, tag_width, data_width, 0) entry0(clk, rst, read_switch[0], read_switch[1], write_entry, acache_hit, bcache_hit, match_bus, instr_tag_bus, instr_IN, instr_tag_IN, tag0_IN, tag1_IN, d0_IN, d1_IN, instr_OUT, d0_OUT, d1_OUT);
TEntryBus #(instr_width, tag_width, data_width, 1) entry1(clk, rst, read_switch[1], read_switch[2], write_entry, acache_hit, bcache_hit, match_bus, instr_tag_bus, instr_IN, instr_tag_IN, tag0_IN, tag1_IN, d0_IN, d1_IN, instr_OUT, d0_OUT, d1_OUT);
TEntryBus #(instr_width, tag_width, data_width, 2) entry2(clk, rst, read_switch[2], read_switch[3], write_entry, acache_hit, bcache_hit, match_bus, instr_tag_bus, instr_IN, instr_tag_IN, tag0_IN, tag1_IN, d0_IN, d1_IN, instr_OUT, d0_OUT, d1_OUT);
TEntryBus #(instr_width, tag_width, data_width, 3) entry3(clk, rst, read_switch[3], read_switch[4], write_entry, acache_hit, bcache_hit, match_bus, instr_tag_bus, instr_IN, instr_tag_IN, tag0_IN, tag1_IN, d0_IN, d1_IN, instr_OUT, d0_OUT, d1_OUT);

endmodule
