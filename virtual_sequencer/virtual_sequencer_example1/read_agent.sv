class read_agent extends uvm_agent;

  `uvm_component_utils(read_agent)

  read_sequencer seqr;
  read_driver    drv;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    seqr = read_sequencer::type_id::create("seqr", this);
    drv  = read_driver::type_id::create("drv", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction

endclass
