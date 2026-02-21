// File Name    :   scoreboard.sv
// Description  :   The scoreboard is responsible to check design functionality and
//                  should track input and try to match the pattern and ensure that
//                  the design has found the pattern as well. The scoreboard should
//                  flag an error if the design didn't find the pattern and ensure
//                  that "out" remains zero, and if the design found the pattern,
//                  "out" is set to the correct value.

class scoreboard extends uvm_scoreboard;
  // Register scoreboard with UVM factory for automation
  `uvm_component_utils(scoreboard)
  
  // Analysis port to receive Packet transactions
  uvm_analysis_imp #(Packet, scoreboard) analysis_imp;
  
  bit[`LENGTH-1:0]   ref_pattern;        // Reference pattern to match against, width defined by LENGTH
  bit[`LENGTH-1:0]   act_pattern;        // Actual pattern observed from DUT inputs
  bit[`LENGTH-1:0]   prev_act_pattern;   // Previous pattern observed to compare with expected output
  bit                exp_out;            // Expected output value for comparison
  
  Packet expected_packet;
  
  // Constructor
  function new(string name="scoreboard", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Instantiate analysis port
    analysis_imp = new("analysis_imp", this);
    
    // Get reference pattern from UVM config DB, error if not found
    if (!uvm_config_db#(bit[`LENGTH-1:0])::get(this, "*", "ref_pattern", ref_pattern))
      `uvm_fatal("SCBD", "Did not get ref_pattern !")
  endfunction

  // Called when a new Packet is received via analysis port
  virtual function write(Packet packet);
    
    // Shift in new input bit to build actual pattern
    act_pattern = act_pattern << 1 | packet.in;
    
    expected_packet = Packet::type_id::create("expected_packet");
    expected_packet.out = exp_out; // set expected output

    // Log current input, output, reference, and actual patterns
    `uvm_info("SCBD", $sformatf("in=%0d out=%0d ref=0b%0b act=0b%0b",
                               packet.in, packet.out, ref_pattern, act_pattern), UVM_LOW)

    // Always check that expected out value is the actual observed value
    // Since it takes 1 clock for out to be updated after pattern match,
    // do the check first and then update exp_out value

    // Option 1: Using field Automation macros
    if (!packet.compare(expected_packet)) begin
      `uvm_error("SCBD", "Packet comparison failed!");
    end
        
    // Option 2: Without automation macros
    if (packet.out != exp_out) begin
      `uvm_error("SCBD", $sformatf("ERROR ! out=%0d exp=%0d",
                                    packet.out, exp_out))
    end else begin
      `uvm_info("SCBD", $sformatf("PASS ! out=%0d exp=%0d",
                                  packet.out, exp_out), UVM_HIGH)
    end
    
    // Additional Checks
    
    // UPDATE Expected Output
    // If current index has reached the full pattern, then set exp_out to be 1
    // which will be checked in the next clock. If pattern is not complete, keep
    // exp_out to zero
    if (!(ref_pattern ^ act_pattern)) begin
      `uvm_info("SCBD", $sformatf("Pattern found to match, next out should be 1"), UVM_LOW)
      exp_out = 1;
    end else begin
      exp_out = 0;
    end

  endfunction
  
endclass
