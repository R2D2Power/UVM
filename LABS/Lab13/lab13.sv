//UVM component
import uvm_pkg::*;
`include "uvm_macros.svh"

class test extends uvm_test;
  `uvm_component_utils(test)
  
  rand bit[31:0]v1;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function print();
    `uvm_info_begin(get_name(), "Variable v1 is printed with this table", UVM_NONE);
    `uvm_message_add_int(v1, UVM_HEX);
    `uvm_info_end
    
  endfunction
  
endclass

module tb;
  test t; 
  initial begin
    t=new("test", null);
    t.randomize();
    t.print();
  end
endmodule
