class consumer extends uvm_component;
  `uvm_component_utils(consumer)
  
  uvm_blocking_put_export #(int) recv;
  uvm_blocking_put_imp #(int, consumer) imp;
  
  function new(input string path = "consumer", uvm_component parent = null);
    super.new(path, parent);  
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    recv  = new("recv", this);
    imp   = new("imp" , this);
  endfunction
  
  task put(int datar);
    `uvm_info("CONS" , $sformatf("Data Rcvd : %0d", datar), UVM_NONE);
  endtask
  
endclass