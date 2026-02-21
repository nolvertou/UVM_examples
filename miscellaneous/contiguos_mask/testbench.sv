module tb;
  bit [3:0] mask;
  
  initial begin
    $display("Mask\tValid?  ");
    for(int i=0; i<16; i++) begin
      mask = i;
      $display("4'b%b\t %0b", mask, is_contiguous(mask));
    end
  end
  
  function automatic bit is_contiguous(input logic [3:0] x);
    int first_set = -1;
    int last_set = -1;
    // Find first and last set bits
    for (int i = 0; i < 4; i++) begin
        if (x[i]) begin
            if (first_set == -1)
                first_set = i;
            last_set = i;
        end
    end
    // If no bits are set, it's contiguous
    if (first_set == -1)
        return 1;
    // Check if all bits between first_set and last_set are set
    for (int i = first_set; i <= last_set; i++) begin
        if (!x[i])
            return 0; // Not contiguous
    end
    return 1; // Contiguous
endfunction


endmodule