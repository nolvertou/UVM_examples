// File Namee	:  random_test_1011.sv
// Description	:	
class random_test_1011 extends base_test;  // Inherit from base_test, which sets up the environment and test infrastructure
   // Register random_test_1011 with the UVM factory for automation
  `uvm_component_utils(random_test_1011)
  
  // Constructor
  function new(string name="random_test_1011", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    pattern = 4'b1011; 					// Set the reference pattern to 1011 for this test
    super.build_phase(phase);			// Call base class build_phase to set up environment and sequence
    
    // Call base class build_phase to set up environment and sequence
    seq.randomize() with { num inside {[300:500]}; };
  endfunction
endclass