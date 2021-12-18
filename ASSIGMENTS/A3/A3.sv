//Assignment 3
import uvm_pkg::*;
`include "uvm_macros.svh"

class mux extends uvm_object;
  `uvm_object_utils(mux)

  rand bit [7:0] A, B, Z;
  rand bit Sel;

  function new(string name="");
    super.new(name);
  endfunction

  task run_mux(input bit[7:0]A, B, input bit Sel);
    this.A=A;
    this.B=B;
    this.Sel=Sel;
    Z=(this.Sel)?(this.A):(this.B);
    `uvm_info(get_name(), $sformatf("Output value of mux is: %0h", Z), UVM_NONE);
  endtask
endclass

class mult extends mux;
  `uvm_object_utils(mult)
  bit[15:0] Z=0;
  int i;

  function new(string name="");
    super.new(name);
  endfunction

  task mult8(input bit[7:0]A, B);
    for(i=0; i<A; i=i+1)begin
      Z=Z+B;
    end
    `uvm_info(get_name(), $sformatf("Output value of mult of A: %0d, and B %0d is %0d", A, B, Z), UVM_NONE);
  endtask
endclass

module tb;
  mult multi;

  initial begin
    multi=mult::type_id::create("multi");
    multi.run_mux(8'h2B, 8'h10, 1'b0);
    multi.mult8(8'h3, 8'h5);
  end
endmodule
