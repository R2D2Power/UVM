//UVM configuration db

import uvm_pkg::*;

`include "uvm_macros.svh"

class env extends uvm_test;
  `uvm_component_utils(env)
  
  string message;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_name(), "Build Phase", UVM_NONE)
    message = "Hola Mundo"; 
    uvm_config_db#(string)::set(this, "test", "test_message", message);
  endfunction 
  
endclass

class test extends uvm_test;
  `uvm_component_utils(test)
  
  env e;
  
  string msg;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    msg = "Default";
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e=env::type_id::create("ENV", this);
  endfunction
  
  task run_phase(uvm_phase phase);
    `uvm_info(get_name(), "Run Phase", UVM_NONE)
    uvm_config_db#(string)::get(e, "test", "test_message", msg);
    `uvm_info(get_name(),msg,UVM_NONE)
  endtask
  
endclass

	module tb;
      test t;
      initial begin
        t=test::type_id::create("TEST", null);
        run_test();
      end
    endmodule

  

