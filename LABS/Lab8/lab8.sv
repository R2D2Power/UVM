//Inheritance
class mux; 
  rand bit[7:0]A;
  rand bit[7:0]B;
  rand bit[7:0]Z;
  rand bit Sel;
  
  task run_mux(input bit[7:0] A, B, input bit Sel);
    this.A=A;
    this.B=B;
    this.Sel=Sel;
    Z=(this.Sel)?(this.A):(this.B);
    $display("Output value of multiplexer is: %oh", Z);
  endtask
  
endclass
  
class mult extends mux;
  bit[15:0] Z=0;
  int i;
  task mult8(input bit [7:0] A,B);
    for(i=0; i<A; i=i+1)begin
      Z=Z+B;
    end
    $display("Result of multiplication of A: %0d, and B %0d, is %0d", A, B, Z);
  endtask
endclass
  
  module tb;
    
    mult mult1;
    
    initial begin
      mult1 = new();
      mult1.run_mux(8'h3B, 8'h21, 1'b0);
      mult1.mult8(8'h5, 8'h10);
    end
    
  endmodule
