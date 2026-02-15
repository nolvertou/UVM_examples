class read_driver extends uvm_driver #(read_item);

  `uvm_component_utils(read_driver)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    read_item req;

    forever begin
      seq_item_port.get_next_item(req);

      `uvm_info("READ_DRIVER",
        $sformatf("READ addr=%h", req.addr),
        UVM_MEDIUM)

      seq_item_port.item_done();
    end
  endtask

endclass
