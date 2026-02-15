class write_seq extends uvm_sequence #(write_item);

  `uvm_object_utils(write_seq)

  function new(string name = "write_seq");
    super.new(name);
  endfunction

  task body();
    write_item req;
    req = write_item::type_id::create("req");

    start_item(req);
    req.addr = 32'h1000;
    req.data = 32'hDEADBEEF;
    finish_item(req);
  endtask

endclass
