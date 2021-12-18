//Asignment 2
import uvm_pkg::*;
`include "uvm_macros.svh"

class gen_rands;
  rand bit [15:0] A, B, Z;
  rand bit en;
  
  task demux();
    Z=(en)?(A):(B);
    $display ("The random value  of A, B, en is: %0h, %0h, %0h", A, B, en);
    $display ("The value of Z is: %0h", Z);
  endtask
endclass

module tb;
  gen_rands gen;
  
  initial begin
    gen=new();
    gen.randomize();
    gen.demux();
  end
endmodule
