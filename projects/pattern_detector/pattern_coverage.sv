// File Name	:	pattern_coverage.sv
// Description	:	

class pattern_coverage extends uvm_subscriber #(Packet);
   // Register with UVM factory for automation
  `uvm_component_utils(pattern_coverage)
  
  bit [3:0] act_pattern; // Shift register to hold last 4 bits
  
  virtual des_if vif;

  covergroup cg_pattern;
    option.per_instance = 1;
    cp_pattern : coverpoint act_pattern iff(vif.rstn) {
      bins other_patterns[] = {[0:10],[12:15]};
      bins pattern_1011 	= {4'b1011};
    }
    
    cp_out : coverpoint(vif.out); 
    
    out_x_1011: cross cp_pattern, cp_out{
      bins pattern_1011_out1 = binsof(cp_pattern.pattern_1011) && binsof(cp_out) intersect{1};
      bins other_patterns_out0 = binsof(cp_pattern.other_patterns) && binsof(cp_out) intersect{0};
      ignore_bins ignore_other_patterns_out1 = binsof(cp_pattern.other_patterns) && binsof(cp_out) intersect{1};
      ignore_bins ignore_pattern1011_out0 = binsof(cp_pattern.pattern_1011) && binsof(cp_out) intersect{0};
    }
  endgroup
 
  // Constructor
  function new(string name = "pattern_coverage", uvm_component parent = null);
    super.new(name, parent);
    cg_pattern = new(); // Instantiate the covergroup
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual des_if)::get(this, "", "des_vif", vif))
      `uvm_fatal("COV", "Did not get vif")
  endfunction

  // Called when a new Packet transaction is received
  function void write(Packet t);
    act_pattern = (act_pattern << 1) | t.in; // Shift in the new bit
    if (vif.rstn)  // Only sample when not in reset
  		cg_pattern.sample(); // Sample the 4-bit pattern
  endfunction
  
  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    $display("Coverage for cg_pattern: %0.2f%%", cg_pattern.get_coverage());
  endfunction

endclass