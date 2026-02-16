`include "uvm_macros.svh"
import uvm_pkg::*;

`include "producer.sv"
`include "consumer.sv"
`include "env.sv"
`include "test.sv"
 
module tb;
 
 initial begin
   run_test("test");
 end
  
endmodule
 
 
 