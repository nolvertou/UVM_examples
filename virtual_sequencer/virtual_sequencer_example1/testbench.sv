  import uvm_pkg::*;
  `include "uvm_macros.svh"
  `include "write_agent_pkg.sv"
  `include "read_agent_pkg.sv"
  import write_agent_pkg::*;
  import read_agent_pkg::*;
  
  `include "virtual_sequencer.sv"
  `include "virtual_sequence.sv"
  `include "my_env.sv"
  `include "my_test.sv"
  
module tb;
 
  initial begin
    run_test("my_test");
  end

endmodule
