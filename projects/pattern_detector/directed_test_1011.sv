class directed_test_1011 extends base_test;
  `uvm_component_utils(directed_test_1011)

  function new(string name="directed_test_1011", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    pattern = 4'b1011; // Set reference pattern
    super.build_phase(phase);
    seq = directed_seq_1011::type_id::create("directed_seq_1011");
  endfunction
endclass
