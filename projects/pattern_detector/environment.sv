// File Name    :   environment.sv
// Description  :   The environment is a container object simply to hold
//                  all verification components together. This environment can
//                  then be reused later and all components in it would be
//                  automatically connected and available for use

class environment extends uvm_env;
  // Register environment with UVM factory for automation
  `uvm_component_utils(environment)
  
  agent         agt;        // Agent handle
  scoreboard    scb;        // Scoreboard handle
  
  // Constructor
  function new(string name="environment", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    agt = agent::type_id::create("agt", this);
    scb = scoreboard::type_id::create("scb", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // Connect the monitor's analysis port to the scoreboard's analysis implementation port
    agt.mon.mon_analysis_port.connect(scb.analysis_imp);
  endfunction
endclass
