class consumer extends uvm_component;
  `uvm_component_utils(consumer)
  
  uvm_blocking_get_port  #(my_transaction) get_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    get_port  = new("get_port", this);
  endfunction

  task run_phase(uvm_phase phase);
    my_transaction tr;
    forever begin
      #1;
      get_port.get(tr);   // Consume the transaction
      `uvm_info("CONSUMER", $sformatf("Got transaction %0d", tr.data), UVM_MEDIUM)
    end
  endtask
endclass
