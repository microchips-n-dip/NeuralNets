`include "MAS.v"

module NodeRouter(clk, in_stream, out_stream);

parameter layer_id = 1;
parameter net_width = 4;
parameter nw_dims = 2;

parameter data_width = 128;
parameter stream_width = data_width + net_width;

parameter net0_offset = nw_full * (layer_id - 0);
parameter naddr0_end = nw_full + net0_offset;
parameter net1_offset = nw_full * (layer_id - 1);
parameter naddr1_end = nw_full + net1_offset;

parameter nei0 [0:nw_full];
parameter upper_id = 0;

parameter nw_full = 2 * nw_dims;

input clk;
input [stream_width-1:0] in_stream [0:nw_full];
output [stream_width-1:0] out_stream [0:nw_full];

genvar i;
genvar j;
genvar k;
genvar l;
generate
wire via [0:nw_full] [0:nw_full];
for (i = 0; i <= nw_full; i = i + 1)
begin
  wire [net_width-1:0] naddr_req;
  assign naddr_req = in_stream[i][stream_width-1:stream_width-net_width];
  wire cond_local = naddr_req[naddr1_end-1:net1_offset] == upper_id;
  wire via_prev[0:nw_dims];
  assign via_prev[0] = 0;
  for (j = 0; j < nw_dims; j = j + 1)
  begin
    k = 2 * j;
    l = 1 + k;
    wire [nw_full:0] addr;
    assign addr = cond_local ? naddr_req[l + net0_offset:k + net0_offset] : 0;
    assign via[k][i] = (addr == nei[k]) & ~via_prev[j];
    assign via[k + 1][i] = (addr == nei[k + 1]) & ~via_prev[j];
    assign via_prev[j + 1] = via[k][i] | via[k + 1][i] | via_prev[j];
  end
  assign via[nw_full][i] = ~via_prev[nw_dims];
end
for (i = 0; i <= nw_full; i = i + 1)
begin
  wire acti0;
  wire acti1;
  wire [stream_width-1:0] outi;
  AST #(2, stream_width) \
    ast(clk, via[i][0:nw_full-1], in_stream[0:nw_full-1], outi, acti0);
  AST #(1, stream_width) \
    asm(clk, {acti0, via[i][nw_full]}, {outi, in_stream[nw_full], out_stream[i], acti1);
end
endgenerate

endmodule

module CoreRouter(clk, in_stream, out_stream);

parameter layer_id = 2;
parameter net_width = 4;
parameter nw_full = 4;
parameter nw_half = 2;

parameter data_width = 128;
parameter stream_width = data_width + net_width;

parameter net0_offset = nw_full * (layer_id - 0);
parameter naddr0_end = nw_full + net0_offset;
parameter naddr0_mid = nw_half + net0_offset;

parameter net1_offset = nw_full * (layer_id - 1);
parameter naddr1_end = nw_full + net1_offset;
parameter naddr1_mid = nw_half + net1_offset;

parameter net2_offset = nw_full * (layer_id - 2);
parameter naddr2_end = nw_full + net2_offset;
parameter naddr2_mid = nw_half + net2_offset;

parameter super_id = 0;
parameter upper_id = 0;

parameter nei0x_upper = 0;
parameter nei1x_upper = 0;
parameter nei2y_upper = 0;
parameter nei3y_upper = 0;

parameter nei0x_lower = 0;
parameter nei1x_lower = 0;
parameter nei2y_lower = 0;
parameter nei3y_lower = 0;

parameter lower_x = 0;
parameter upper_x = 0;
parameter lower_y = 0;
parameter upper_y = 0;

input clk;
input [stream_width-1:0] in_stream [0:7];
output [stream_width-1:0] out_stream [0:7];

wire [net_width-1:0] naddr0_req [0:7];
assign naddr0_req[0] = in_stream[0][stream_width-1:stream_width-net_width];
assign naddr0_req[1] = in_stream[1][stream_width-1:stream_width-net_width];
assign naddr0_req[2] = in_stream[2][stream_width-1:stream_width-net_width];
assign naddr0_req[3] = in_stream[3][stream_width-1:stream_width-net_width];
assign naddr0_req[4] = in_stream[4][stream_width-1:stream_width-net_width];
assign naddr0_req[5] = in_stream[5][stream_width-1:stream_width-net_width];
assign naddr0_req[6] = in_stream[6][stream_width-1:stream_width-net_width];
assign naddr0_req[7] = in_stream[7][stream_width-1:stream_width-net_width];

wire upper_addr0x = (naddr0_req[0][net1_offset-1:net2_offset] == super_id) ? naddr0_req[0][naddr1_mid-1:net1_offset] : 0;
wire upper_addr0y = (naddr0_req[0][net1_offset-1:net2_offset] == super_id) ? naddr0_req[0][naddr1_end-1:naddr1_mid] : 0;
wire upper_addr1x = (naddr0_req[1][net1_offset-1:net2_offset] == super_id) ? naddr0_req[1][naddr1_mid-1:net1_offset] : 0;
wire upper_addr1y = (naddr0_req[1][net1_offset-1:net2_offset] == super_id) ? naddr0_req[1][naddr1_end-1:naddr1_mid] : 0;
wire upper_addr2x = (naddr0_req[2][net1_offset-1:net2_offset] == super_id) ? naddr0_req[2][naddr1_mid-1:net1_offset] : 0;
wire upper_addr2y = (naddr0_req[2][net1_offset-1:net2_offset] == super_id) ? naddr0_req[2][naddr1_end-1:naddr1_mid] : 0;
wire upper_addr3x = (naddr0_req[3][net1_offset-1:net2_offset] == super_id) ? naddr0_req[3][naddr1_mid-1:net1_offset] : 0;
wire upper_addr3y = (naddr0_req[3][net1_offset-1:net2_offset] == super_id) ? naddr0_req[3][naddr1_end-1:naddr1_mid] : 0;
wire upper_addr4x = (naddr0_req[4][net1_offset-1:net2_offset] == super_id) ? naddr0_req[4][naddr1_mid-1:net1_offset] : 0;
wire upper_addr4y = (naddr0_req[4][net1_offset-1:net2_offset] == super_id) ? naddr0_req[4][naddr1_end-1:naddr1_mid] : 0;
wire upper_addr5x = (naddr0_req[5][net1_offset-1:net2_offset] == super_id) ? naddr0_req[5][naddr1_mid-1:net1_offset] : 0;
wire upper_addr5y = (naddr0_req[5][net1_offset-1:net2_offset] == super_id) ? naddr0_req[5][naddr1_end-1:naddr1_mid] : 0;
wire upper_addr6x = (naddr0_req[6][net1_offset-1:net2_offset] == super_id) ? naddr0_req[6][naddr1_mid-1:net1_offset] : 0;
wire upper_addr6y = (naddr0_req[6][net1_offset-1:net2_offset] == super_id) ? naddr0_req[6][naddr1_end-1:naddr1_mid] : 0;
wire upper_addr7x = (naddr0_req[7][net1_offset-1:net2_offset] == super_id) ? naddr0_req[7][naddr1_mid-1:net1_offset] : 0;
wire upper_addr7y = (naddr0_req[7][net1_offset-1:net2_offset] == super_id) ? naddr0_req[7][naddr1_end-1:naddr1_mid] : 0;

wire via_00_upper = upper_addr0x == nei0x_upper;
wire via_01_upper = upper_addr0x == nei1x_upper;
wire via_0x_upper = via_00_upper | via_01_upper;
wire via_02_upper = (upper_addr0y == nei2y_upper) & ~via_0x_upper;
wire via_03_upper = (upper_addr0y == nei3y_upper) & ~via_0x_upper;
wire via_0z_upper = via_00_upper | via_01_upper | via_02_upper | via_03_upper;
wire via_10_upper = upper_addr1x == nei0x_upper;
wire via_11_upper = upper_addr1x == nei1x_upper;
wire via_1x_upper = via_10_upper | via_11_upper;
wire via_12_upper = (upper_addr1y == nei2y_upper) & ~via_1x_upper;
wire via_13_upper = (upper_addr1y == nei3y_upper) & ~via_1x_upper;
wire via_1z_upper = via_10_upper | via_11_upper | via_12_upper | via_13_upper;
wire via_20_upper = upper_addr2x == nei0x_upper;
wire via_21_upper = upper_addr2x == nei1x_upper;
wire via_2x_upper = via_20_upper | via_21_upper;
wire via_22_upper = (upper_addr2y == nei2y_upper) & ~via_2x_upper;
wire via_23_upper = (upper_addr2y == nei3y_upper) & ~via_2x_upper;
wire via_2z_upper = via_20_upper | via_21_upper | via_22_upper | via_23_upper;
wire via_30_upper = upper_addr3x == nei0x_upper;
wire via_31_upper = upper_addr3x == nei1x_upper;
wire via_3x_upper = via_30_upper | via_31_upper;
wire via_32_upper = (upper_addr3y == nei2y_upper) & ~via_3x_upper;
wire via_33_upper = (upper_addr3y == nei3y_upper) & ~via_3x_upper;
wire via_3z_upper = via_30_upper | via_31_upper | via_32_upper | via_33_upper;
wire via_40_upper = upper_addr4x == nei0x_upper;
wire via_41_upper = upper_addr4x == nei1x_upper;
wire via_4x_upper = via_40_upper | via_41_upper;
wire via_42_upper = (upper_addr4y == nei2y_upper) & ~via_4x_upper;
wire via_43_upper = (upper_addr4y == nei3y_upper) & ~via_4x_upper;
wire via_4z_upper = via_40_upper | via_41_upper | via_42_upper | via_43_upper;
wire via_50_upper = upper_addr5x == nei0x_upper;
wire via_51_upper = upper_addr5x == nei1x_upper;
wire via_5x_upper = via_50_upper | via_51_upper;
wire via_52_upper = (upper_addr5y == nei2y_upper) & ~via_5x_upper;
wire via_53_upper = (upper_addr5y == nei3y_upper) & ~via_5x_upper;
wire via_5z_upper = via_50_upper | via_51_upper | via_52_upper | via_53_upper;
wire via_60_upper = upper_addr6x == nei0x_upper;
wire via_61_upper = upper_addr6x == nei1x_upper;
wire via_6x_upper = via_60_upper | via_61_upper;
wire via_62_upper = (upper_addr6y == nei2y_upper) & ~via_6x_upper;
wire via_63_upper = (upper_addr6y == nei3y_upper) & ~via_6x_upper;
wire via_6z_upper = via_60_upper | via_61_upper | via_62_upper | via_63_upper;
wire via_70_upper = upper_addr7x == nei0x_upper;
wire via_71_upper = upper_addr7x == nei1x_upper;
wire via_7x_upper = via_70_upper | via_71_upper;
wire via_72_upper = (upper_addr7y == nei2y_upper) & ~via_7x_upper;
wire via_73_upper = (upper_addr7y == nei3y_upper) & ~via_7x_upper;
wire via_7z_upper = via_70_upper | via_71_upper | via_72_upper | via_73_upper;

wire lower_addr0x = (naddr0_req[0][naddr1_end-1:net1_offset] == upper_id) ? naddr0_req[0][naddr0_mid-1:net0_offset] : 0;
wire lower_addr0y = (naddr0_req[0][naddr1_end-1:net1_offset] == upper_id) ? naddr0_req[0][naddr0_end-1:naddr0_mid] : 0;
wire lower_addr1x = (naddr0_req[1][naddr1_end-1:net1_offset] == upper_id) ? naddr0_req[1][naddr0_mid-1:net0_offset] : 0;
wire lower_addr1y = (naddr0_req[1][naddr1_end-1:net1_offset] == upper_id) ? naddr0_req[1][naddr0_end-1:naddr0_mid] : 0;
wire lower_addr2x = (naddr0_req[2][naddr1_end-1:net1_offset] == upper_id) ? naddr0_req[2][naddr0_mid-1:net0_offset] : 0;
wire lower_addr2y = (naddr0_req[2][naddr1_end-1:net1_offset] == upper_id) ? naddr0_req[2][naddr0_end-1:naddr0_mid] : 0;
wire lower_addr3x = (naddr0_req[3][naddr1_end-1:net1_offset] == upper_id) ? naddr0_req[3][naddr0_mid-1:net0_offset] : 0;
wire lower_addr3y = (naddr0_req[3][naddr1_end-1:net1_offset] == upper_id) ? naddr0_req[3][naddr0_end-1:naddr0_mid] : 0;
wire lower_addr4x = (naddr0_req[4][naddr1_end-1:net1_offset] == upper_id) ? naddr0_req[4][naddr0_mid-1:net0_offset] : 0;
wire lower_addr4y = (naddr0_req[4][naddr1_end-1:net1_offset] == upper_id) ? naddr0_req[4][naddr0_end-1:naddr0_mid] : 0;
wire lower_addr5x = (naddr0_req[5][naddr1_end-1:net1_offset] == upper_id) ? naddr0_req[5][naddr0_mid-1:net0_offset] : 0;
wire lower_addr5y = (naddr0_req[5][naddr1_end-1:net1_offset] == upper_id) ? naddr0_req[5][naddr0_end-1:naddr0_mid] : 0;
wire lower_addr6x = (naddr0_req[6][naddr1_end-1:net1_offset] == upper_id) ? naddr0_req[6][naddr0_mid-1:net0_offset] : 0;
wire lower_addr6y = (naddr0_req[6][naddr1_end-1:net1_offset] == upper_id) ? naddr0_req[6][naddr0_end-1:naddr0_mid] : 0;
wire lower_addr7x = (naddr0_req[7][naddr1_end-1:net1_offset] == upper_id) ? naddr0_req[7][naddr0_mid-1:net0_offset] : 0;
wire lower_addr7y = (naddr0_req[7][naddr1_end-1:net1_offset] == upper_id) ? naddr0_req[7][naddr0_end-1:naddr0_mid] : 0;

wire via_00_lower = (lower_addr0x == nei0x_lower) & ~via_0z_upper;
wire via_01_lower = (lower_addr0x == nei1x_lower) & ~via_0z_upper;
wire via_0x_lower = via_00_lower | via_01_lower;
wire via_02_lower = (lower_addr0y == nei2y_lower) & ~via_0z_upper & ~via_0x_lower;
wire via_03_lower = (lower_addr0y == nei3y_lower) & ~via_0z_upper & ~via_0x_lower;
wire via_10_lower = (lower_addr1x == nei0x_lower) & ~via_1z_upper;
wire via_11_lower = (lower_addr1x == nei1x_lower) & ~via_1z_upper;
wire via_1x_lower = via_00_lower | via_01_lower;
wire via_12_lower = (lower_addr1y == nei2y_lower) & ~via_1z_upper & ~via_1x_lower;
wire via_13_lower = (lower_addr1y == nei3y_lower) & ~via_1z_upper & ~via_1x_lower;
wire via_20_lower = (lower_addr2x == nei0x_lower) & ~via_2z_upper;
wire via_21_lower = (lower_addr2x == nei1x_lower) & ~via_2z_upper;
wire via_2x_lower = via_00_lower | via_01_lower;
wire via_22_lower = (lower_addr2y == nei2y_lower) & ~via_2z_upper & ~via_2x_lower;
wire via_23_lower = (lower_addr2y == nei3y_lower) & ~via_2z_upper & ~via_2x_lower;
wire via_30_lower = (lower_addr3x == nei0x_lower) & ~via_3z_upper;
wire via_31_lower = (lower_addr3x == nei1x_lower) & ~via_3z_upper;
wire via_3x_lower = via_00_lower | via_01_lower;
wire via_32_lower = (lower_addr3y == nei2y_lower) & ~via_3z_upper & ~via_3x_lower;
wire via_33_lower = (lower_addr3y == nei3y_lower) & ~via_3z_upper & ~via_3x_lower;
wire via_40_lower = (lower_addr4x == nei0x_lower) & ~via_4z_upper;
wire via_41_lower = (lower_addr4x == nei1x_lower) & ~via_4z_upper;
wire via_4x_lower = via_00_lower | via_01_lower;
wire via_42_lower = (lower_addr4y == nei2y_lower) & ~via_4z_upper & ~via_4x_lower;
wire via_43_lower = (lower_addr4y == nei3y_lower) & ~via_4z_upper & ~via_4x_lower;
wire via_50_lower = (lower_addr5x == nei0x_lower) & ~via_5z_upper;
wire via_51_lower = (lower_addr5x == nei1x_lower) & ~via_5z_upper;
wire via_5x_lower = via_00_lower | via_01_lower;
wire via_52_lower = (lower_addr5y == nei2y_lower) & ~via_5z_upper & ~via_5x_lower;
wire via_53_lower = (lower_addr5y == nei3y_lower) & ~via_5z_upper & ~via_5x_lower;
wire via_60_lower = (lower_addr6x == nei0x_lower) & ~via_6z_upper;
wire via_61_lower = (lower_addr6x == nei1x_lower) & ~via_6z_upper;
wire via_6x_lower = via_00_lower | via_01_lower;
wire via_62_lower = (lower_addr6y == nei2y_lower) & ~via_6z_upper & ~via_6x_lower;
wire via_63_lower = (lower_addr6y == nei3y_lower) & ~via_6z_upper & ~via_6x_lower;
wire via_70_lower = (lower_addr7x == nei0x_lower) & ~via_7z_upper;
wire via_71_lower = (lower_addr7x == nei1x_lower) & ~via_7z_upper;
wire via_7x_lower = via_00_lower | via_01_lower;
wire via_72_lower = (lower_addr7y == nei2y_lower) & ~via_7z_upper & ~via_7x_lower;
wire via_73_lower = (lower_addr7y == nei3y_lower) & ~via_7z_upper & ~via_7x_lower;

AST #(3, stream_width) ast0(clk, {via_00_upper, via_10_upper, via_20_upper, via_30_upper, via_40_upper, via_50_upper, via_60_upper, via_70_upper}, in_stream, out_stream[0]);
AST #(3, stream_width) ast1(clk, {via_01_upper, via_11_upper, via_21_upper, via_31_upper, via_41_upper, via_51_upper, via_61_upper, via_71_upper}, in_stream, out_stream[1]);
AST #(3, stream_width) ast2(clk, {via_02_upper, via_12_upper, via_22_upper, via_32_upper, via_42_upper, via_52_upper, via_62_upper, via_72_upper}, in_stream, out_stream[2]);
AST #(3, stream_width) ast3(clk, {via_03_upper, via_13_upper, via_23_upper, via_33_upper, via_43_upper, via_53_upper, via_63_upper, via_73_upper}, in_stream, out_stream[3]);
AST #(3, stream_width) ast4(clk, {via_00_lower, via_10_lower, via_20_lower, via_30_lower, via_40_lower, via_50_lower, via_60_lower, via_70_lower}, in_stream, out_stream[4]);
AST #(3, stream_width) ast5(clk, {via_01_lower, via_11_lower, via_21_lower, via_31_lower, via_41_lower, via_51_lower, via_61_lower, via_71_lower}, in_stream, out_stream[5]);
AST #(3, stream_width) ast6(clk, {via_02_lower, via_12_lower, via_22_lower, via_32_lower, via_42_lower, via_52_lower, via_62_lower, via_72_lower}, in_stream, out_stream[6]);
AST #(3, stream_width) ast7(clk, {via_03_lower, via_13_lower, via_23_lower, via_33_lower, via_43_lower, via_53_lower, via_63_lower, via_73_lower}, in_stream, out_stream[7]);

endmodule
