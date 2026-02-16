//--------------------------------------------------------------
// Test
//--------------------------------------------------------------
class my_test extends uvm_test;
  `uvm_component_utils(my_test)

  producer prod;
  consumer cons;

  function new(string name = "my_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    prod = producer::type_id::create("prod", this);
    cons = consumer::type_id::create("cons", this);

    prod.m_num_tx = 2;
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    prod.m_put_port.connect(cons.m_put_imp);
  endfunction

  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction
endclass