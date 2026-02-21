`include "uvm_macros.svh"
import uvm_pkg::*;

`include "my_tb_pkg.svh"
import my_tb_pkg::*;

//--------------------------------------------------------------
// Testbench top module starts running UVM test
//--------------------------------------------------------------
module tb;
  initial 
    begin
      run_test("my_test");
    end
endmodule
