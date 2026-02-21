// File Name		: tb.sv
// Description		: Testbench Top File
// Reference link   : https://www.chipverify.com/uvm/uvm-verification-testbench-example

// Include UVM macros for utility functions and automation and Import the UVM package for verification components
`include "uvm_macros.svh"
 import uvm_pkg::*;

`include "uvc_detector_pkg.sv"
import uvc_detector_pkg::*;

// // Interface definition for DUT communication
`include "des_if.sv"

module tb;
  reg clk;

  // Clock Generator: toggles clk every 10 time units
  always #10 clk =~ clk;
  
  // Instantiate the interface, connecting it to the clock
  des_if _if (clk);

  // Instantiate the DUT and connect its ports
  det_1011 u0 (.clk(clk),
               .rstn(_if.rstn),
               .in(_if.in),
               .out(_if.out));
	
  // set up simulation
  initial begin
    clk <= 0;
    
    //uvm_top.set_report_verbosity_level(UVM_HIGH);

    
    // Set the virtual interface for UVM components
    uvm_config_db#(virtual des_if)::set(null, "uvm_test_top", "des_vif", _if);
    
    // Start the UVM test named "test_1011"
    run_test("random_test_1011");
  end
  
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
  end
endmodule