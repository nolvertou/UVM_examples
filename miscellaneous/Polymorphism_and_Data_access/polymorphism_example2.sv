class Animal;
  virtual function void make_sound();
  endfunction
endclass

class Dog extends Animal;
  function void make_sound();
    $display("Woof!");
  endfunction
endclass

class Cat extends Animal;
  function void make_sound();
    $display("Meow!");
  endfunction
endclass

module test;
  
  Animal a;
  Dog d;
  Cat c;

  initial begin
    d = new();
    a = d;
    a.make_sound(); 

    c = new();
    a = c;
    a.make_sound(); 
  end
endmodule
