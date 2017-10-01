module router(clk, in_req, in_addr, out_addr);

// BTW, don't ask me why the inputs are all 6 bits
// I was originally thinking of putting this on banks with 6 bit address sizes

// I/O
input clk; // Clock line
input in_req [0:35]; // Input direction requests
input [5:0] in_addr [0:5]; // Input address
output [5:0] out_addr [0:5]; // Output address

// The reason we use AST_6 here is because we are on a 3x3 torus with sub-layers
// Each scheduler is for one of the six outputs from each of the inputs

AST_6 ast1(clk, in_req[0:5], in_addr, out_addr[0]);
AST_6 ast2(clk, in_req[6:11], in_addr, out_addr[1]);
AST_6 ast3(clk, in_req[12:17], in_addr, out_addr[2]);
AST_6 ast4(clk, in_req[18:23], in_addr, out_addr[3]);
AST_6 ast5(clk, in_req[24:29], in_addr, out_addr[4]);
AST_6 ast6(clk, in_req[30:35], in_addr, out_addr[5]);

endmodule
