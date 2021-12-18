//Assignment 1
import uvm_pkg::*;
`include "uvm_macros.svh"

module tb;
  logic[3:0] a=4'b1111, b=4'b0110, c=4'b10zx;
  bit d=1'b0;
  
  initial begin
    `uvm_info("[TEST]", $sformatf("Hexadecimal values of four state variables a, b, c: %0h, %0h, %0h", a, b, c), UVM_NONE);
    `uvm_info("[TEST]", $sformatf("Haxadecimal values of four state variables d: %0h", d), UVM_NONE);
  end
endmodule
