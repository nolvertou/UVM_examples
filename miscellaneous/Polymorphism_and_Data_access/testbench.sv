class A;
    int x;
    local int y;

    function new();
        x = 1;
        y = 2;
    endfunction

    function void show();
        $display("A: x=%0d, y=%0d", x, y);
    endfunction
endclass

class B extends A;
    
    function void show();
        $display("B: x=%0d", x);
    endfunction
endclass

class C extends B;
    function void show();
        $display("C: x=%0d", x);
    endfunction
endclass

module test;
    A a;
    B b;
    C c;

    initial begin
        b = new();
        a = b;
        a.show();

        c = new();
        b = c;
        b.show();

        $display("c.x = %0d", c.x);
       // $display("c.y = %0d", c.y);
    end
endmodule
