//UVM component
import uvm_pkg::*;
`include "uvm_macros.svh"

class comp1 extends uvm_component;
  `uvm_component_utils(comp1)
  
  string data;
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
    data=name;
  endfunction
  
  task run();
    $display("instance name: %s", data);
    `uvm_info(get_name(), $sformatf("instance name: %s", data), UVM_NONE);
  endtask
endclass

module tb;
  comp1 s; 
  initial begin
    s=new("s", null);
    s.run();
  end
endmodule
