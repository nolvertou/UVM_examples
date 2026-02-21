class seq_item extends uvm_sequence_item;
  rand bit [7:0] a, b;
  bit [8:0] y;

  function new(string name = "seq_item");
    super.new(name);
  endfunction

  `uvm_object_utils_begin(seq_item)
  `uvm_field_int(a,UVM_ALL_ON)
  `uvm_field_int(b,UVM_ALL_ON)
  `uvm_object_utils_end

  constraint limit_c {a < 100; b < 100;}
endclass