class read_seq extends uvm_sequence #(read_item);

  `uvm_object_utils(read_seq)

  function new(string name = "read_seq");
    super.new(name);
  endfunction

  task body();
    read_item req;
    req = read_item::type_id::create("req");

    start_item(req);
    req.addr = 32'h1000;
    finish_item(req);
  endtask

endclass
