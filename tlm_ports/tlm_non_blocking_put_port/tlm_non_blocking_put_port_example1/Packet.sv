//--------------------------------------------------------------
// Transaction: Packet
//--------------------------------------------------------------
class Packet extends uvm_object;
  rand bit [7:0] addr;
  rand bit [7:0] data;

  `uvm_object_utils_begin(Packet)
    `uvm_field_int(addr, UVM_ALL_ON)
    `uvm_field_int(data, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "Packet");
    super.new(name);
  endfunction
endclass