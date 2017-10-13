`include "MAS.v"

module NodeRouter(clk, naddr_req, in_stream, out_stream);

parameter nei0x = 0;
parameter nei1x = 0;
parameter nei2y = 0;
parameter nei3y = 0;

parameter layer_id = 0;
parameter net_width = 4;
parameter stream_width = 144;
parameter nw_full = 4;
parameter nw_half = 2;

parameter net0_offset = nw_full * layer_id;
parameter naddr_end = nw_full + net0_offset;
parameter naddr_mid = nw_half + net0_offset;

parameter net1_offset = nw_full * (layer_id - 1);
parameter nparent_end = nw_full + net1_offset;
parameter nparent_mid = nw_half + net1_offset;

parameter self_x = 0;
parameter self_y = 0;

// TODO: Manage trans-layer requests

input clk;
input [stream_width-1:0] in_stream [0:4];
output [stream_width-1:0] out_stream [0:4];

wire [net_width-1:0] naddr_req [0:4];
assign naddr_req[0] = in_stream[0][stream_width-1:stream_width-net_width];
assign naddr_req[1] = in_stream[1][stream_width-1:stream_width-net_width];
assign naddr_req[2] = in_stream[2][stream_width-1:stream_width-net_width];
assign naddr_req[3] = in_stream[3][stream_width-1:stream_width-net_width];
assign naddr_req[4] = in_stream[4][stream_width-1:stream_width-net_width];

wire addr0x = (naddr_req[0][nparent_end-1:net1_offset] == layer_id) ? naddr_req[0][naddr_mid-1:net0_offset] : 0;
wire addr0y = (naddr_req[0][nparent_end-1:net1_offset] == layer_id) ? naddr_req[0][naddr_end-1:naddr_mid] : 0;
wire addr1x = (naddr_req[1][nparent_end-1:net1_offset] == layer_id) ? naddr_req[1][naddr_mid-1:net0_offset] : 0;
wire addr1y = (naddr_req[1][nparent_end-1:net1_offset] == layer_id) ? naddr_req[1][naddr_end-1:naddr_mid] : 0;
wire addr2x = (naddr_req[2][nparent_end-1:net1_offset] == layer_id) ? naddr_req[2][naddr_mid-1:net0_offset] : 0;
wire addr2y = (naddr_req[2][nparent_end-1:net1_offset] == layer_id) ? naddr_req[2][naddr_en,m,m.d-1:naddr_mid] : 0;
wire addr3x = (naddr_req[3][nparent_end-1:net1_offset] == layer_id) ? naddr_req[3][naddr_mid-1:net0_offset] : 0;
wire addr3y = (naddr_req[3][nparent_end-1:net1_offset] == layer_id) ? naddr_req[3][naddr_end-1:naddr_mid] : 0;
wire addr4x = (naddr_req[4][nparent_end-1:net1_offset] == layer_id) ? naddr_req[4][naddr_mid-1:net0_offset] : 0;
wire addr4y = (naddr_req[4][nparent_end-1:net1_offset] == layer_id) ? naddr_req[4][naddr_end-1:naddr_mid] : 0;

wire via_00 = addr0x >= nei0x;
wire via_01 = addr0x <= nei1x;
wire via_0x = via_00 | via_01;
wire via_02 = (addr0y >= nei2y) & ~via_0x;
wire via_03 = (addr0y <= nei3y) & ~via_0x;
wire via_10 = addr1x >= nei0x;
wire via_11 = addr2x <= nei1x;
wire via_1x = via_10 | via_11;
wire via_12 = (addr1y >= nei2y) & ~via_1x;
wire via_13 = (addr1y <= nei3y) & ~via_1x;
wire via_20 = addr2x >= nei0x;
wire via_21 = addr2x <= nei1x;
wire via_2x = via_20 | via_21;
wire via_22 = (addr2y >= nei2y) & ~via_2x;
wire via_23 = (addr2y <= nei3y) & ~via_2x;
wire via_30 = addr3x >= nei0x;
wire via_31 = addr3x <= nei1x;
wire via_3x = via_30 | via_31;
wire via_32 = (addr3y >= nei2y) & ~via_3x;
wire via_33 = (addr3y <= nei3y) & ~via_3x;
wire via_40 = addr4x >= nei0x;
wire via_41 = addr4x <= nei1x;
wire via_4x = via_40 | via_41;
wire via_42 = (addr4y >= nei2y) & ~via_4x;
wire via_43 = (addr4y <= nei3y) & ~via_4x;

wire via_04 = (addr0x == self_x) & (addr0y == self_y);
wire via_14 = (addr1x == self_x) & (addr1y == self_y);
wire via_24 = (addr2x == self_x) & (addr2y == self_y);
wire via_34 = (addr3x == self_x) & (addr3y == self_y);
wire via_44 = (addr4x == self_x) & (addr4y == self_y);

AST_5 ast1(clk, {via_00, via_10, via_20, via_30, via_40}, in_stream, out_stream[0]);
AST_5 ast2(clk, {via_01, via_11, via_21, via_31, via_41}, in_stream, out_stream[1]);
AST_5 ast3(clk, {via_02, via_12, via_22, via_32, via_42}, in_stream, out_stream[2]);
AST_5 ast4(clk, {via_03, via_13, via_23, via_33, via_43}, in_stream, out_stream[3]);
AST_5 ast5(clk, {via_04, via_14, via_24, via_34, via_44}, in_stream, out_stream[4]);

endmodule
