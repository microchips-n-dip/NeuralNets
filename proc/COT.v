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
parameter nei_1_ = n * y + ((x + 1) % n);
parameter nei_2_ = n * y + ((x + 2) % n);
parameter nei_1 = (nei_1_ < nei_2_) ? nei_1_ : nei_2_;
parameter nei_2 = (nei_1_ < nei_2_) ? nei_2_ : nei_1_;
parameter nei_3_ = n * ((y + 1) % n) + x;
parameter nei_4_ = n * ((y + 2) % n) + x;
parameter nei_3 = (nei_3_ < nei_4_) ? nei_3_ : nei_4_;
parameter nei_4 = (nei_3_ < nei_4_) ? nei_4_ : nei_3_;
parameter nei_5 = ;
parameter nei_6 = ;

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

Core #(.i(0), .n(3)) core0(clk);
Core #(.i(1), .n(3)) core1(clk);
Core #(.i(2), .n(3)) core2(clk);
Core #(.i(3), .n(3)) core3(clk);
Core #(.i(4), .n(3)) core4(clk);
Core #(.i(5), .n(3)) core5(clk);
Core #(.i(6), .n(3)) core6(clk);
Core #(.i(7), .n(3)) core7(clk);
Core #(.i(8), .n(3)) core8(clk); 

endmodule