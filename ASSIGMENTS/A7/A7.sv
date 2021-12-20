// Assignment 7
import uvm_pkg::*;
`include "uvm_macros.svh"

class test extends uvm_test;
  `uvm_component_utils(test)
  
  rand bit [31:0] test;
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function print();
    `uvm_info_begin(get_name(), "Value of test is displayed", UVM_NONE);
    `uvm_message_add_int(test, UVM_HEX);
    `uvm_info_end
  endfunction
endclass

module tb;
  test t; 
  
  initial begin
    t=test::type_id::create("test", null);
    t.randomize();
    t.print();
  end
endmodule
