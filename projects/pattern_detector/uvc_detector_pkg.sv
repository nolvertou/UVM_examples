
package uvc_detector_pkg;
`include "uvm_macros.svh"

// Import the UVM package for verification components
 import uvm_pkg::*;

// Define a macro for LENGTH, used for parameterization of pattern size
`define LENGTH 4

// Include all necessary component files for the UVM environment
`include "Packet.sv"			// Base transaction item definition
`include "base_detector_seq.sv" // Sequence for generating items
`include "driver.sv"			// Driver to send transactions to DUT
`include "pattern_coverage.sv"	
`include "monitor.sv"			// Monitor to observe DUT signals
`include "scoreboard.sv"		// Scoreboard for result checking
`include "agent.sv"				// Agent encapsulating driver and monitor
`include "environment.sv"				// Environment containing agents and scoreboard
`include "base_test.sv"			// Base test class
`include "random_test_1011.sv"			// Specific test implementation
`include "directed_seq_1011.sv"
`include "directed_test_1011.sv"
endpackage