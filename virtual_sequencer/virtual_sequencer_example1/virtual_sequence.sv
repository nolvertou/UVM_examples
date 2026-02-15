class virtual_sequence extends uvm_sequence;

  `uvm_object_utils(virtual_sequence)
  `uvm_declare_p_sequencer(virtual_sequencer)

  function new(string name = "virtual_sequence");
    super.new(name);
  endfunction

  task body();

    write_seq wseq;
    read_seq  rseq;

    wseq = write_seq::type_id::create("wseq");
    rseq = read_seq::type_id::create("rseq");

    `uvm_info("VSEQ", "Starting WRITE", UVM_LOW)
    wseq.start(p_sequencer.wr_seqr);

    `uvm_info("VSEQ", "Starting READ", UVM_LOW)
    rseq.start(p_sequencer.rd_seqr);

  endtask

endclass
