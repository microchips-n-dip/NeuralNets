package vl_global_functions;

function unsigned integer [0:1] compute_nei();

input unsigned integer i;
input unsigned integer id;

begin
  unsigned integer j = 1 << (2 * i);
  unsigned integer shift_id = (id >> j) % 4;
  compute_nei[0] = (shift_id + 1) % 3;
  compute_nei[1] = (shift_id + 2) % 3;
end

endfunction

endpackage
