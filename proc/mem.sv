`ifndef JPU_MEM_SVH
`define JPU_MEM_SVH

`include "mux.sv"

// T-flipflop
module TFF(clk, s0, r0, t, q);

input clk;
input s0;
input r0;
input t;
output q;

reg flop;
reg s2;
reg r2;
always @(posedge clk)
begin
  s2 = t & ~flop;
  r2 = t &  flop;
end
wire s = s0 | s2;
wire r = r0 | r2;
always @(*)
begin
  flop = (s | flop) & ~r;
end
assign q = flop;

endmodule

// D-flipflop
module DFF(clk, s0, r0, d, q);

input clk;
input s0;
input r0;
input d;
output q;

reg flop;
reg s2;
always @(posedge clk)
begin
  s2 = d;
end
wire s = s0 | s2;
wire r = r0;
always @(*)
begin
  flop = (s | flop) & ~r;
end
assign q = flop;

endmodule

// SR latch with enable
module SRE(clk, s0, r0, s1, r1, q);

input clk;
input s0;
input r0;
input s1;
input r1;
output q;

reg flop;
reg s2;
reg r2;
always @(posedge clk)
begin
  s2 = s1;
  r2 = r1;
end
wire s = s0 | s2;
wire r = r0 | r2;
always @(*)
begin
  flop = (s | flop) & ~r;
end
assign q = flop;

endmodule

// Register with enable and reset
module Reg(clk, en, rst, data_IN, data_OUT);

parameter width = 8;

input clk;
input en;
input rst;
input [width-1:0] data_IN;
output [width-1:0] data_OUT;

genvar i;
generate
for (i = 0; i < width; i = i + 1)
begin
  DFF dff0(clk & en, 0, rst, data_IN[i], data_OUT[i]);
end
endgenerate

endmodule

// Register file
module MultiReg(clk, rst, write_addr, read_addr, data_IN, data_OUT);

parameter addr_width = 3;
parameter data_width = 8;

parameter n_read = 1;

parameter n_modules = 1 << addr_width;

input clk;
input rst;
input [addr_width-1:0] write_addr;
input [addr_width-1:0] read_addr [0:n_read-1];
input [data_width-1:0] data_IN;
output [data_width-1:0] data_OUT [0:n_read-1];

genvar i;
genvar j;

generate
wire [data_width-1:0] outs [0:n_modules-1];
for (i = 0; i < n_modules; i = i + 1)
begin
  wire write_enable = write_addr == i;
  Reg #(data_width) r0(clk, write_enable, rst, data_IN, outs[i]);
end
for (i = 0; i < n_read; i = i + 1)
begin
  Mux #(addr_width, data_width) mux(read_addr[i], outs, data_OUT[i]);
end
endgenerate

endmodule

// Stack
module Stack(clk, rst, push, pop, data_IN, data_OUT);

parameter length = 8;
parameter data_width = 8;

input clk;
input rst;
input push;
input pop;
input [data_width-1:0] data_IN;
output [data_width-1:0] data_OUT;

wire [data_width-1:0] push_stream [0:length];
wire [data_width-1:0] pop_stream  [0:length];

wire en = push | pop;
assign push_stream[0] = data_IN;
assign data_OUT = pop_stream[0];

genvar i;

generate
for (i = 0; i < length; i = i + 1)
begin
  wire [data_width-1:0] r0_write_data;
  wire [data_width-1:0] r0_read_data;
  Mux2 #(data_width) write_switch(pop, push_stream[i], pop_stream[i + 1], r0_write_data);
  Reg #(data_width) r0(clk, en, rst, r0_write_data, r0_read_data);
  assign push_stream[i + 1] = r0_read_data;
  assign pop_stream[i] = r0_read_data;
end
endgenerate

endmodule

`endif
