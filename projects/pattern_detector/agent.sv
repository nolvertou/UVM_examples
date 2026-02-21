// File Name    :   agent.sv
// Description  :   Create an intermediate container called "agent" to hold
//                  driver, monitor and sequencer
class agent extends uvm_agent;
  // Register agent with UVM factory for automation
  `uvm_component_utils(agent)
  
  // Constructor
  function new(string name="agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  driver              drv;        // Driver handle
  monitor             mon;        // Monitor handle
  uvm_sequencer #(Packet) seqcr;  // Sequencer Handle

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // Create sequencer, driver, and monitor components
    seqcr = uvm_sequencer#(Packet)::type_id::create("seqcr", this);
    drv   = driver::type_id::create("drv", this);
    mon   = monitor::type_id::create("mon", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // Connect the driver's seq_item_port to the sequencer's seq_item_export
    drv.seq_item_port.connect(seqcr.seq_item_export);
  endfunction

endclass
