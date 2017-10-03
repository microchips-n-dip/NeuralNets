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

module Core(clk);

input clk; // Clock line

// Torus address and coordinates
parameter i;
parameter n;
parameter x = i % n;
parameter y = floor(i / n);

// Core neighbor address computation
parameter nei_0_x = (x + 1) % n;
parameter nei_0_ = n * y + nei_0_x;
parameter nei_1_x = (x + n - 1) % n;
parameter nei_1_ = n * y + nei_1_x;
// Switch in case of left wrapping
parameter nei_0 = ((nei_1_x - x) == 1) ? nei_0_ : nei_1_;
parameter nei_1 = ((nei_1_x - x) == 1) ? nei_1_ : nei_0_;
parameter nei_2_y = (y + 1) % n;
parameter nei_2_ = n * nei_2_y + x;
parameter nei_3_y = (y + n - 1) % n;
parameter nei_3_ = n * nei_3_y + x;
// Switch in case of top wrapping
parameter nei_2 = ((nei_3_y - y) == 1) ? nei_2_ : nei_3_;
parameter nei_3 = ((nei_3_y - y) == 1) ? nei_3_ : nei_2_;
parameter en_nei_4 = 0;
parameter nei_4 = 0;
parameter en_nei_5 = 0;
parameter nei_5 = 0;

reg dests [0:5];

Router router(clk, ); // Core's router

reg [7:0] rf_ptr [0:15];

ThreadProc thread_1(clk);
ThreadProc thread_2(clk);
ThreadProc thread_3(clk);
ThreadProc thread_4(clk);

endmodule

module TorusInterconnect(clk);

input clk; // Clock line

parameter n = 3;

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

//   2
// 0   1
//   3

Core #(.i(0), .n(3)) core0(clk, {c1[0], c2[1], c3[2], c6[3]}, c0);
Core #(.i(1), .n(3)) core1(clk, {c0[1], c2[0], c4[2], c7[3]}, c1);
Core #(.i(2), .n(3)) core2(clk, {c0[0], c1[1], c5[2], c8[3]}, c2);
Core #(.i(3), .n(3)) core3(clk, {c4[0], c5[1], c0[3], c6[2]}, c3);
Core #(.i(4), .n(3)) core4(clk, {c3[1], c5[0], c1[3], c7[2]}, c4);
Core #(.i(5), .n(3)) core5(clk, {c3[0], c4[1], c2[3], c8[2]}, c5);
Core #(.i(6), .n(3)) core6(clk, {c7[0], c8[1], c0[3], c2[2]}, c6);
Core #(.i(7), .n(3)) core7(clk, {c6[1], c8[0], c1[3], c4[2]}, c7);
Core #(.i(8), .n(3)) core8(clk, {c6[0], c7[1], c2[3], c5[2]}, c8); 

endmodule