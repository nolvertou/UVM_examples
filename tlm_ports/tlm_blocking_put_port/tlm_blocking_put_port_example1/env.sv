class env extends uvm_env;
  `uvm_component_utils(env)
 
  producer p;
  consumer c;
 
  function new(input string path = "env", uvm_component parent = null);
    super.new(path, parent);
  endfunction
 
 virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  p = producer::type_id::create("p",this);
  c = consumer::type_id::create("c", this);
 endfunction
  
 virtual function void connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   p.send.connect(c.recv);
   c.recv.connect(c.imp); 
 endfunction
 
endclass