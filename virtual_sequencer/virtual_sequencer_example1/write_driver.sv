class write_driver extends uvm_driver #(write_item);

  `uvm_component_utils(write_driver)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    write_item req;

    forever begin
      seq_item_port.get_next_item(req);

      `uvm_info("WRITE_DRIVER",
        $sformatf("WRITE addr=%h data=%h", req.addr, req.data),
        UVM_MEDIUM)

      seq_item_port.item_done();
    end
  endtask

endclass
