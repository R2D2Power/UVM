//Assigment 4
import uvm_pkg::*;
`include "uvm_macros.svh"

class Op_parent extends uvm_object;
  `uvm_object_utils(Op_parent)
  
  bit [15:0] Z;
  
  function new(string name="");
    super.new(name);
  endfunction
  
  virtual task run(input bit[7:0]A, B);
    Z=A*B;
    `uvm_info(get_name(), $sformatf("[PARENT] Output value of mult is: %0d, size: %0d", Z, $size(Z)), UVM_NONE);
  endtask
endclass

class Op_child extends Op_parent;
  `uvm_object_utils(Op_child)
  bit[8:0] Z=0;
  
  function new(string name="");
    super.new(name);
  endfunction
  
  task run(input bit[7:0]A, B);
    Z=Z+B;
    `uvm_info(get_name(), $sformatf("[CHILD] Output value of sum is: %0d, size: %0d", Z, $size(Z)), UVM_NONE);
  endtask
endclass

module tb;
  Op_parent parent;
  Op_child child;
  
  initial begin
    child=Op_child::type_id::create("child");
    parent=child;
    parent.run(8'h2B, 8'h12);
  end
endmodule
