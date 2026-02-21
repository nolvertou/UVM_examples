// This is the base transaction object that will be used
// in the environment to initiate new transactions and
// capture transactions at DUT interface
class Packet extends uvm_sequence_item;
  //`uvm_object_utils(Packet)
  rand bit  in;
  bit 		out;
  
  `uvm_object_utils_begin(Packet)
  `uvm_field_int(in, UVM_DEFAULT | UVM_NOCOMPARE)
  `uvm_field_int(out, UVM_DEFAULT )
  `uvm_object_utils_end

  virtual function string convert2str();
    return $sformatf("in=%0d, out=%0d", in, out);
  endfunction

  function new(string name = "Packet");
    super.new(name);
  endfunction
	
  // constraints
  constraint c_in_values { in dist {0:/20, 1:/80}; }
endclass
