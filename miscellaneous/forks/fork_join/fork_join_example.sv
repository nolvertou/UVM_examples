module fork_join_example;
    initial begin
        $display("Start of initial block at time %0t", $time);
        fork
            begin
                #10;
                $display("Task 1 finished at time %0t", $time);
            end
            begin
                #5;
                $display("Task 2 finished at time %0t", $time);
            end
        join_none
        $display("End of initial block at time %0t", $time);
    end
endmodule
