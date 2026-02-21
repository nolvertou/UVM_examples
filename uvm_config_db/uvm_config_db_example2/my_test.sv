class my_test extends uvm_test;
  `uvm_component_utils(my_test)
  my_env env;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = my_env::type_id::create("env", this);
    
    // Set the number of transactions in a test using config_db
    uvm_config_db#(int)::set(null,"uvm_test_top", "txns", 3); // context,  instance_name, field_name, value
  endfunction
endclass
