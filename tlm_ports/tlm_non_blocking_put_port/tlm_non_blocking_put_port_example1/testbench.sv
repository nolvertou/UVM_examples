//--------------------------------------------------------------
// Top
//--------------------------------------------------------------
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "Packet.sv"
`include "producer.sv"
`include "consumer.sv"
`include "my_test.sv"

module tb;
  initial
    run_test("my_test");
endmodule
