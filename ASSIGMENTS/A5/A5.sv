//Assigment 5
import uvm_pkg::*;
`include "uvm_macros.svh"

class driver extends uvm_driver;
  `uvm_component_utils(driver)
  
  bit signal;
  bit [7:0] data;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function assign_values(input bit signal, input bit [7:0]data);
    this.signal=signal;
    this.data=data;
  endfunction
  
  task run();
    `uvm_info(get_name(), $sformatf("[DRV] Signal value is: %0b, data value is: %0d", this.signal, this.data), UVM_NONE);
  endtask
endclass

class agent extends uvm_agent;
  `uvm_component_utils(agent)
  driver drv;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  task run();
    drv=driver::type_id::create("DRV", this);
    drv.assign_values(1'b1, 8'd80);
    drv.run;
  endtask
endclass

module tb;
  agent g;
  
  initial begin
    g=agent::type_id::create("g", null);
    g.run();
  end
endmodule
