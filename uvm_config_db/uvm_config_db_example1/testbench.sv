`include "uvm_macros.svh"
import uvm_pkg::*;

`include "my_tb_pkg.svh"
import my_tb_pkg::*;

`include "add_if.sv"

module tb_top;
  bit clk;
  bit reset;
  always #2 clk = ~clk;
  
  initial begin
    //clk = 0;
    reset = 1;
    #5; 
    reset = 0;
  end
  add_if vif(clk, reset);
  
  adder DUT(.clk(vif.clk),.reset(vif.reset),.a(vif.a),.b(vif.b),.y(vif.y));
  
  initial begin
    // Examples about setting a value in the uvm_config_db
    
    /* Example 1: Global Set (Wildcard Path)
     - Sets vif for all components in the testbench hierarchy.
     - Useful for small testbenches or when all components need the same interface.
     - uvm_root::get() is equivalent to null in this context.*/
    uvm_config_db#(virtual add_if)::set(uvm_root::get(), "*", "vif", vif);
    
    /* Example 2: Global Set (null handle)
     - Also sets vif for all components.
     - null is commonly used and recommended.
     */
    // uvm_config_db#(virtual add_if)::set(null, "*", "vif", vif);
    
    /* Example 3
     ILLEGAL, Keyword 'this' cannot be used here in the top
     - Not legal in initial blocks outside a class context. 
     - Only use this inside class methods.
     */
    // uvm_config_db#(virtual add_if)::set(this, "*", "vif", vif); 
    
    /* Example 4 : Specific Component Path
     - Sets vif only for the driver and monitor.
     - Use the actual instance names in your hierarchy.*/
    //uvm_config_db#(virtual add_if)::set(null, "uvm_test_top.env.agt.drv", "vif", vif);
    //uvm_config_db#(virtual add_if)::set(null, "uvm_test_top.env.agt.mon", "vif", vif);
    
    /* Example 5 : Wildcard Under Agent
     - Sets vif for all components under agt (e.g., driver, monitor, etc.).*/
    //uvm_config_db#(virtual add_if)::set(null, "uvm_test_top.env.agt.*", "vif", vif);
    
  end
  initial begin
    run_test("base_test");
  end
endmodule