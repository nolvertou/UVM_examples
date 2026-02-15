class write_item extends uvm_sequence_item;
  
  `uvm_object_utils(write_item)

  rand bit [31:0] addr;
  rand bit [31:0] data;

  function new(string name = "write_item");
    super.new(name);
  endfunction

endclass