// File Name    :   base_test.sv
// Description  :   Test class instantiates the environment and starts it.

class base_test extends uvm_test;
  // Register base_test with UVM factory for automation
  `uvm_component_utils(base_test)
  
  environment         env;                 // Handle for the environment component
  bit[`LENGTH-1:0]    pattern = 4'b1011;  // Reference pattern to be used in the test
  base_detector_seq   seq;                // Handle for the sequence to generate stimulus
  virtual   des_if    vif;                // Virtual interface handle for DUT connection
  
  // Constructor
  function new(string name = "base_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create the environment
    env = environment::type_id::create("env", this);

    // Get virtual IF handle from top level and pass it to everything
    // in env level
    if (!uvm_config_db#(virtual des_if)::get(this, "", "des_vif", vif))
      `uvm_fatal("TEST", "Did not get vif")
      
    // Pass the virtual interface handle to all agent components in the environment
      uvm_config_db#(virtual des_if)::set(this, "env.agt.*", "des_vif", vif);

    // Setup pattern queue and place into config db
    uvm_config_db#(bit[`LENGTH-1:0])::set(this, "*", "ref_pattern", pattern);

    // Create sequence and randomize it
    seq = base_detector_seq::type_id::create("seq");
    seq.randomize();
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);    // Raise objection to keep simulation running
    apply_reset();
    seq.start(env.agt.seqcr);         // Start the sequence on the agent's sequencer
    //#200;                         // Wait for 200 time units
    phase.drop_objection(this);     // Drop objection to allow simulation to finish
  endtask

  virtual task apply_reset();
    vif.rstn <= 0;                  // Assert reset
    vif.in <= 0;                    // Set input to zero
    repeat(5) @ (posedge vif.clk);  // Wait for 5 clock cycles
    vif.rstn <= 1;                  // Deassert reset
    //repeat(10) @ (posedge vif.clk); // Wait for 10 clock cycles after reset
  endtask
endclass
