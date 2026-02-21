class my_env extends uvm_env;
  `uvm_component_utils(my_env)
  
  producer prod;
  consumer cons;
  uvm_tlm_fifo #(my_transaction) fifo;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    prod = producer::type_id::create("prod", this);
    cons = consumer::type_id::create("cons", this);
    fifo = new("fifo", this, 5); // 5 is the depth of the FIFO
  endfunction

  function void connect_phase(uvm_phase phase);
    prod.put_port.connect(fifo.put_export);
    cons.get_port.connect(fifo.get_export);
  endfunction
endclass