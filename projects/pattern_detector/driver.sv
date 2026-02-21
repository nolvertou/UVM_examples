// File Name    :   driver.sv
// Description  :   The driver is responsible for driving transactions to the DUT
//                  All it does is to get a transaction from the mailbox if it is
//                  available and drive it out into the DUT interface.

class driver extends uvm_driver #(Packet);
  // Register the driver class with the UVM factory
  `uvm_component_utils(driver)
  
  // Virtual interface handle for connecting to the DUT signals
  virtual des_if vif;
  
  // Constructor
  function new(string name = "driver", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  // Build phase: retrieves the virtual interface from the UVM configuration database
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Get the virtual interface; fatal error if not found
    if (!uvm_config_db#(virtual des_if)::get(this, "", "des_vif", vif))
      `uvm_fatal("DRV", "Could not get vif")
  endfunction

  // Run phase: main driver loop, waits for transactions and drives them to the DUT
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    forever begin
      Packet packet;
      
      // Informational message: waiting for next packet from sequencer
      `uvm_info("DRV", $sformatf("Wait for packet from sequencer"), UVM_HIGH)
      
      // Get the next transaction packet from the sequencer
      seq_item_port.get_next_item(packet);
      
      // Drive the transaction to the DUT
      drive_packet(packet);
      
      // Notify sequencer that the packet is done
      seq_item_port.item_done();
    end
  endtask

  // Task to drive a single transaction to the DUT interface
  virtual task drive_packet(Packet packet);
    // Wait for the clocking block event
    @(vif.cb);
    // Drive the input signal to the DUT using the interface
    vif.cb.in <= packet.in;
  endtask
endclass
