// Compare less than module
module cmpl(a, b, lt);

input a;
input b;
output lt;

wire bres = ~(a & b) & b;
assign lt = bres[0]|bres[1]|bres[2]|bres[3]|bres[4]|bres[5]|bres[6]|bres[7];

endmodule