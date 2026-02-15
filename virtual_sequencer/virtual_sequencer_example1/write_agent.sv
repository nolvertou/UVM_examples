class write_agent extends uvm_agent;

  `uvm_component_utils(write_agent)

  write_sequencer seqr;
  write_driver    drv;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    seqr = write_sequencer::type_id::create("seqr", this);
    drv  = write_driver::type_id::create("drv", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction

endclass
