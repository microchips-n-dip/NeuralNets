module BankSlice(clk);

input clk;

parameter width = 8;
parameter size = 6;
parameter tsize = pow(2, size);

reg [width:0] bank [0:tsize];

endmodule

module ThreadProc(clk, en_write, write_id, read_id, en_a, en_b, alu_op, en_alu_out);

input clk; // Clock line
input en_write; // Enable regfile write flag
input [1:0] write_id; // ID of register to write
input [1:0] read_id; // ID of register to read
input en_a; // Enable write to A register
input en_b; // Enable write to B register
input [1:0] alu_op; // ALU opcode
input en_alu_out; // Enable alu output

reg [7:0] rf [0:3]; // Register file
reg [7:0] RF_EX; // RF to EX stage register
reg [7:0] alu_a; // ALU input A register
reg [7:0] alu_b; // ALU input B register
reg [7:0] EX_WB; // EX to WB stage register

ALU alu(clk, alu_a, alu_b, en_alu_out, EX_WB); // ALU

// Pipeline triggered by clock
always @(posedge clk)
  RF_EX <= rf[read_id];
  if (en_a)
    alu_a <= RF_EX;
  end
  if (en_b)
    alu_b <= RF_EX;
  end
  if (en_write)
    rf[write_id] <= EX_WB;
  end
end

endmodule

// Implementation of other core types...?

class Core;

// Torus address and coordinates
parameter i;
parameter n;
parameter x = i % n;
parameter y = floor(i / n);

// Core neighbor address computation
// Computing neighbors in x direction
parameter nei_0_x = (x + 1) % n;
parameter nei_0_ = n * y + nei_0_x;
parameter nei_1_x = (x + n - 1) % n;
parameter nei_1_ = n * y + nei_1_x;
// Switch in case of left wrapping
parameter nei_0 = ((nei_1_x - x) == 1) ? nei_0_ : nei_1_;
parameter nei_1 = ((nei_1_x - x) == 1) ? nei_1_ : nei_0_;
// Computing neighbors in y direction
parameter nei_2_y = (y + 1) % n;
parameter nei_2_ = n * nei_2_y + x;
parameter nei_3_y = (y + n - 1) % n;
parameter nei_3_ = n * nei_3_y + x;
// Switch in case of top wrapping
parameter nei_2 = ((nei_3_y - y) == 1) ? nei_2_ : nei_3_;
parameter nei_3 = ((nei_3_y - y) == 1) ? nei_3_ : nei_2_;
// Parent/child neighbor settings
parameter en_nei_4 = 0;
parameter nei_4 = 0;
parameter en_nei_5 = 0;
parameter nei_5 = 0;

reg dests [0:5];

// TODO: Finish up with router
Router router(clk, ); // Core's router

// Banks
// All cores have banks
// Include intercore requesting in IS?
// Compiler defined mem requests?
parameter bank_size = 6;

BankSlice #(.size(bank_size)) bank_00(clk);
BankSlice #(.size(bank_size)) bank_01(clk);
BankSlice #(.size(bank_size)) bank_10(clk);
BankSlice #(.size(bank_size)) bank_11(clk);

virtual task core_run(clk);

reg [7:0] rf_ptr [0:15];

ThreadProc thread_1(clk);
ThreadProc thread_2(clk);
ThreadProc thread_3(clk);
ThreadProc thread_4(clk);

endtask;

endmodule

module TorusInterconnect(clk);

parameter type CoreType0;
parameter type CoreType1;
parameter type CoreType2;
parameter type CoreType3;
parameter type CoreType4;
parameter type CoreType5;
parameter type CoreType6;
parameter type CoreType7;
parameter type CoreType8;

input clk; // Clock line

parameter n = 3;
parameter root_addr = ;

parameter en_sub_0 = 0;
parameter sub_0 = 0;
parameter en_sub_1 = 0;
parameter sub_1 = 0;
parameter en_sub_2 = 0;
parameter sub_2 = 0;
parameter en_sub_3 = 0;
parameter sub_3 = 0;
parameter en_sub_4 = 0;
parameter sub_4 = 0;
parameter en_sub_5 = 0;
parameter sub_5 = 0;
parameter en_sub_6 = 0;
parameter sub_6 = 0;
parameter en_sub_7 = 0;
parameter sub_7 = 0;
parameter en_sub_8 = 0;
parameter sub_8 = 0;

// Bank params
// All bank sizes measured in address bits
parameter bank_sz_0 = 6;
parameter bank_sz_1 = 6;
parameter bank_sz_2 = 6;
parameter bank_sz_3 = 6;
parameter bank_sz_4 = 6;
parameter bank_sz_5 = 6;
parameter bank_sz_6 = 6;
parameter bank_sz_7 = 6;
parameter bank_sz_8 = 6;

// Interconnect wires
wire c0 [0:3];
wire c1 [0:3];
wire c2 [0:3];
wire c3 [0:3];
wire c4 [0:3];
wire c5 [0:3];
wire c6 [0:3];
wire c7 [0:3];
wire c8 [0:3];

// Core neighbor index layout
//   2
// 0   1
//   3

CoreType0 #(.i(0), .n(3), .en_nei_5(en_sub_0), .nei_5(sub_0), .bank_size(bank_sz_0)) core0(clk, {c1[0], c2[1], c3[2], c6[3]}, c0);
CoreType1 #(.i(1), .n(3), .en_nei_5(en_sub_1), .nei_5(sub_1), .bank_size(bank_sz_1)) core1(clk, {c2[0], c0[1], c4[2], c7[3]}, c1);
CoreType2 #(.i(2), .n(3), .en_nei_5(en_sub_2), .nei_5(sub_2), .bank_size(bank_sz_2)) core2(clk, {c0[0], c1[1], c5[2], c8[3]}, c2);
CoreType3 #(.i(3), .n(3), .en_nei_5(en_sub_3), .nei_5(sub_3), .bank_size(bank_sz_3)) core3(clk, {c4[0], c5[1], c6[2], c0[3]}, c3);
CoreType4 #(.i(4), .n(3), .en_nei_4(1), .nei_4(root_addr), .en_nei_5(en_sub_4), .nei_5(sub_4), .bank_size(bank_sz_4)) core4(clk, {c3[1], c5[0], c1[3], c7[2]}, c4);
CoreType5 #(.i(5), .n(3), .en_nei_5(en_sub_5), .nei_5(sub_5), .bank_size(bank_sz_5)) core5(clk, {c3[0], c4[1], c8[2], c2[3]}, c5);
CoreType6 #(.i(6), .n(3), .en_nei_5(en_sub_6), .nei_5(sub_6), .bank_size(bank_sz_6)) core6(clk, {c7[0], c8[1], c3[2], c0[3]}, c6);
CoreType7 #(.i(7), .n(3), .en_nei_5(en_sub_7), .nei_5(sub_7), .bank_size(bank_sz_7)) core7(clk, {c8[0], c6[1], c4[2], c1[3]}, c7);
CoreType8 #(.i(8), .n(3), .en_nei_5(en_sub_8), .nei_5(sub_8), .bank_size(bank_sz_8)) core8(clk, {c6[0], c7[1], c5[2], c2[3]}, c8); 

endmodule
