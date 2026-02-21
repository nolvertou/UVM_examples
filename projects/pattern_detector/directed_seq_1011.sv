class directed_seq_1011 extends base_detector_seq;
  `uvm_object_utils(directed_seq_1011)

  function new(string name="directed_seq_1011");
    super.new(name);
    num = 4; // Only four transactions
  endfunction

  virtual task body();
    int pattern[4] = '{1, 0, 1, 1};
    for (int i = 0; i <=  3; i++) begin
      Packet packet = Packet::type_id::create($sformatf("packet_%0d", i));
      start_item(packet);
      packet.in = pattern[i]; // Set directed value
      //packet.randomize() with { in == pattern[i]; }; // If you want to randomize other fields
      
      finish_item(packet);
      `uvm_info("SEQ", $sformatf("Sent packet: %s", packet.convert2str()), UVM_LOW)
    end
    `uvm_info("SEQ", "Done sending 1011 sequence", UVM_LOW)
    #40;
  endtask
endclass
