//Assignment 6
import uvm_pkg::*;
`include "uvm_macros.svh"

class component extends uvm_component;
  `uvm_component_utils(component)
  string data;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    data=name;
  endfunction
  
  task run();
    $display("Instance name is: %s", data);
    `uvm_info(get_name(), $sformatf("Instance name is: %s", data), UVM_NONE);
  endtask
endclass

module tb;
  component c;
  
  initial begin
    c=component::type_id::create("c", null);
    c.run();
  end
endmodule
