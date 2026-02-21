// File Name		: des_if.sv
// Description		: The interface allows verification components to access DUT signals using a virtual interface handle
// Reference link   : https://www.chipverify.com/uvm/uvm-verification-testbench-example

interface des_if (input bit clk);
  logic rstn;		// Reset signal (active low)
  logic in;			// Input signal to DUT
  logic out;		// Output signal from DUT

  // Define a clocking block for synchronizing inputs and outputs to posedge of clk
  clocking cb @(posedge clk);
    //default input #1step output #3ns;	// Set default input and output skews for timing
    input out;							// Sample 'out' signal on clock edge
    output in;							// Drive 'in' signal on clock edge
  endclocking
  
endinterface