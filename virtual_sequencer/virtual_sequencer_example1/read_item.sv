class read_item extends uvm_sequence_item;
  
  `uvm_object_utils(read_item)

  rand bit [31:0] addr;

  function new(string name = "read_item");
    super.new(name);
  endfunction

endclass