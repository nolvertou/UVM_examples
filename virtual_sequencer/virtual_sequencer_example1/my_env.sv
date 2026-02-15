class my_env extends uvm_env;

  `uvm_component_utils(my_env)

  write_agent        wr_agent;
  read_agent         rd_agent;
  virtual_sequencer  vseqr;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    wr_agent = write_agent::type_id::create("wr_agent", this);
    rd_agent = read_agent::type_id::create("rd_agent", this);
    vseqr    = virtual_sequencer::type_id::create("vseqr", this);
  endfunction

  function void connect_phase(uvm_phase phase);

    vseqr.wr_seqr = wr_agent.seqr;
    vseqr.rd_seqr = rd_agent.seqr;

  endfunction

endclass
