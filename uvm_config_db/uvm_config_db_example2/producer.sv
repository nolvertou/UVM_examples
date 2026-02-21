class producer extends uvm_component;
  `uvm_component_utils(producer)
  
  uvm_blocking_put_port #(my_transaction) put_port;
  int txns;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    put_port = new("put_port", this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(uvm_config_db#(int)::get(null, "uvm_test_top", "txns", txns))
      `uvm_info("PROD", $sformatf("number of txns to be sent: %0d", txns), UVM_NONE)
    else
      `uvm_error("PROD", "Unable to access the value of txns")
  endfunction

  task run_phase(uvm_phase phase);
    my_transaction tr;
    for (int i = 0; i < txns; i++) begin
      tr = my_transaction::type_id::create("tr");
      tr.data = i;
      `uvm_info("PRODUCER", $sformatf("Producing transaction %0d", tr.data), UVM_MEDIUM)
      put_port.put(tr);
    end
  endtask
endclass
