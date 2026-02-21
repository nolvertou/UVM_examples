// File Name      : base_detector_seq.sv
// Description    : Sequence class to generate and send multiple Packet transactions
//                  to the driver in a UVM environment.

class base_detector_seq extends uvm_sequence;
  // Register the sequence class with the UVM factory
  `uvm_object_utils(base_detector_seq)
  
  // Constructor
  function new(string name="base_detector_seq");
    super.new(name);
  endfunction

  // Randomizable integer to configure the total number of packets to be sent
  rand int num;
  //int num = 10;
  
  // Constraint: by default, num will be randomized between 10 and 50
  //constraint c_num_txns { soft num inside {[10:50]}; }

  // Main sequence body: generates and sends 'num' Packet transactions
  virtual task body();
    for (int i = 0; i < num; i ++) begin
      // Create a new Packet transaction object
      Packet packet = Packet::type_id::create("packet");
      
      // Start the transaction (handshake with driver)
      start_item(packet);
      
      // Randomize the transaction fields according to constraints
      packet.randomize();
      
      // Print debug information about the generated packet
      `uvm_info("SEQ", $sformatf("Generate new packet: %s", packet.convert2str()), UVM_NONE)
      
      // Finish the transaction (handshake with driver)
      finish_item(packet);
    end
    
    // Print debug information when sequence is done
    `uvm_info("SEQ", $sformatf("Done generation of %0d packets", num), UVM_LOW)
  endtask
endclass
