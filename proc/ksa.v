module KSA_G(g0, p1, g1, g2);

input g0;
input p1;
input g1;
output g2;

assign g2 = g1 | (g0 & p1);

endmodule

module KSA_Y(p0, g0, p1, g1, p2, g2);

input p0;
input g0;
input p1;
input g1;
output p2;
output g2;

assign p2 = p1 & p0;
assign g2 = g1 | (g0 & p1);

endmodule

module KoggeStoneAdder8(a, b, o, cin, cout);

input [7:0] a;
input [7:0] b;
input cin;
output [7:0] o;
output cout;

wire [7:0] p0 = a ^ b;
wire [7:0] g0 = a & b;

wire [7:1] p1;
wire [7:0] g1;
KSA_G ksag00(cin, p0[0], g0[0], g1[0]);
KSA_Y ksay01(p0[0], g0[0], p0[1], g0[1], p1[1], g2[1]);
KSA_Y ksay02(p0[1], g0[1], p0[2], g0[2], p1[2], g2[2]);
KSA_Y ksay03(p0[2], g0[2], p0[3], g0[3], p1[3], g2[3]);
KSA_Y ksay04(p0[3], g0[3], p0[4], g0[4], p1[4], g2[4]);
KSA_Y ksay05(p0[4], g0[4], p0[5], g0[5], p1[5], g2[5]);
KSA_Y ksay06(p0[5], g0[5], p0[6], g0[6], p1[6], g2[6]);
KSA_Y ksay07(p0[6], g0[6], p0[7], g0[7], p1[7], g2[7]);

wire [7:3] p2;
wire [7:0] g2;
assign g2[0] = g1[0];
KSA_G ksag11(cin, p1[1], g1[1], g2[1]);
KSA_G ksag12(g1[0], p1[2], g1[2], g2[2]);
KSA_Y ksay13(p1[1], g1[1], p1[3], g1[3], p2[3], g2[3]);
KSA_Y ksay14(p1[2], g1[2], p1[4], g1[4], p2[4], g2[4]);
KSA_Y ksay15(p1[3], g1[3], p1[5], g1[5], p2[5], g2[5]);
KSA_Y ksay16(p1[4], g1[4], p1[6], g1[6], p2[6], g2[6]);
KSA_Y ksay17(p1[5], g1[5], p1[7], g1[7], p2[7], g2[7]);

wire [7:7] p3;
wire [7:0] g3;
assign g3[0] = g2[0];
assign g3[1] = g2[1];
assign g3[2] = g2[2];
KSA_G ksag23(cin, p2[3], g2[3], g3[3]);
KSA_G ksag24(g2[0], p2[4], g2[4], g3[4]);
KSA_G ksag25(g2[1], p2[5], g2[5], g3[5]);
KSA_G ksag26(g2[2], p2[6], g2[6], g3[6]);
KSA_Y ksay27(p2[3], g2[3], p2[7], g2[7], p3[7], g3[7]);

KSA_G ksag37(cin, p3[7], g3[7], cout);

assign o[0] = cin ^ p0[0];
assign o[1] = g3[0] ^ p0[1];
assign o[2] = g3[1] ^ p0[2];
assign o[3] = g3[2] ^ p0[3];
assign o[4] = g3[3] ^ p0[4];
assign o[5] = g3[4] ^ p0[5];
assign o[6] = g3[5] ^ p0[6];
assign o[7] = g3[6] ^ p0[7];

endmodule
