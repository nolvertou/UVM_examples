module adder(input clk, reset, input [7:0] a, b, output reg [8:0] y);
  always@(posedge clk or posedge reset) begin 
    if(reset) y <= 0;
    else y <= a + b;
  end
endmodule