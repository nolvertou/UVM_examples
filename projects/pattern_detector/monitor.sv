// File name    :   monitor.sv
// Description  :   The monitor has a virtual interface handle with which
//                  it can monitor the events happening on the interface.
//                  It sees new transactions and then captures information
//                  into a packet and sends it to the scoreboard by TLM port

class monitor extends uvm_monitor;
  // Register the monitor class with the UVM factory
  `uvm_component_utils(monitor)
  
  // Analysis port for broadcasting observed transactions to subscribers (e.g., scoreboard)
  uvm_analysis_port  #(Packet) mon_analysis_port;
  
  // Virtual interface handle for accessing DUT signals
  virtual des_if vif;
  
  pattern_coverage cov; // Coverage collector
  
  // Constructor
  function new(string name="monitor", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  // Build phase: retrieves the virtual interface and creates the analysis port
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Create the analysis port for publishing observed packets
    mon_analysis_port = new ("mon_analysis_port", this);
    
    // Get the virtual interface from the UVM configuration database
    if (!uvm_config_db#(virtual des_if)::get(this, "", "des_vif", vif))
      `uvm_fatal("MON", "Could not get vif")
      
    // Create the coverage collector instance
    cov = pattern_coverage::type_id::create("cov", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    // This task monitors the interface for a complete
    // transaction and writes into analysis port when complete
    forever begin
      @ (vif.cb);            // Wait for clocking block event (synchronization)
      if (vif.rstn) begin    // Only capture transactions when not in reset
        // Create a new Packet transaction object
        Packet packet = Packet::type_id::create("packet");
        // Capture input and output signals from the interface
        packet.in = vif.in;
        packet.out = vif.cb.out;
        // Write the observed transaction to the analysis port
        mon_analysis_port.write(packet);
        //packet.print(uvm_default_line_printer);
        
        // Sample coverage for the observed packet
        if (cov != null) begin
          cov.write(packet);
          `uvm_info("MON", $sformatf("Collecting coverage for: %s", packet.convert2str()), UVM_HIGH)
        end
        
        // Print debug information about the observed packet
        `uvm_info("MON", $sformatf("Saw packet %s", packet.convert2str()), UVM_HIGH)
      end
    end
  endtask
endclass
