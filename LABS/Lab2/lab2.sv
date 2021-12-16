//Factory
import uvm_pkg::*;

`include "uvm_macros.svh"

class test extends uvm_test;
  `uvm_component_utils(test)
  function new(string name, uvm_component parant);
    super.new(name, parant);
  endfunction
  
  task run_phase(uvm_phase phase);
    `uvm_info(get_name(), "Hello World", UVM_NONE)
  endtask
endclass

module tb;
  test t;
  
  initial begin
    t = test::type_id::create("TEST", null); 
    run_test();
  end
endmodule
