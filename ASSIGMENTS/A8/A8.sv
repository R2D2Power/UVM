//Assignment 8
import uvm_pkg::*;
`include "uvm_macros.svh"

class driver extends uvm_driver;
  `uvm_component_utils(driver)
  
  function new(input string inst, uvm_component c);
    super.new(inst, c);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("DEBUG", "Build Phase", UVM_NONE);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("DEBUG", "Connect Phase", UVM_NONE);
  endfunction
  
  task run_phase(uvm_phase phase);
    `uvm_info("DEBUG", "Run Phase", UVM_NONE);
  endtask
  
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("DEBUG", "Report Phase", UVM_NONE);
  endfunction
  
endclass

class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  
  function new (input string inst, uvm_component c);
    super.new(inst, c);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("DEBUG", "Build Phase", UVM_NONE)
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("DEBUG", "Connect Phase", UVM_NONE)
  endfunction 
  
  task run_phase(uvm_phase phase);
    `uvm_info("DEBUG", "Run Phase", UVM_NONE)
  endtask
  
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("DEBUG", "Report Phase", UVM_NONE)
  endfunction
  
endclass
//----------------------------------------
class agent extends uvm_agent;
  `uvm_component_utils(agent)
  
  monitor m;
  driver d;
  scoreboard s;
  
  function new(input string inst, uvm_component c);
    super.new(inst, c);
  endfunction 
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("DEBUG", "Build Phase", UVM_NONE)
    m=monitor::type_id::create("MON", this);
    d=driver::type_id::create("DRV", this);
    s=scoreboard::type_id::create("SCR", this);
    
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("DEBUG", "Connect Phase", UVM_NONE)
  endfunction
  
  task run_phase(uvm_phase phase);
    `uvm_info("DEBUG", "Run Phase", UVM_NONE)
  endtask
  
  function void report_phase(uvm_phase phase);
    super.report_phase(phase)
    `uvm_info("DEBUG", "Report Phase", UVM_NONE)
  endfunction 
  
endclass
//--------------------------------------------
class env extends uvm_env;
  `uvm_component_utils(env)
  
  agent a; 
  
  function new(input string inst, uvm_component c);
    super.new(inst,c);
  endfunction 
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("DEBUG", "Build Phase", UVM_NONE)
    a = agent::type_id::create("AGENT", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("DEBUG", "Connect Phase", UVM_NONE);
  endfunction 
  
  task run_phase(uvm_phase phase);
    `uvm_info("DEBUG", "Run Phase", UVM_NONE);
  endtask
  
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("DEBUG", "Report Phase", UVM_NONE)
  endfunction 
  
endclass

class test extends uvm_test;
  `uvm_component_utils(test)
  
  env e;
  
  function new(input string inst, uvm_component c);
    super.new(inst,c);
  endfunction 
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("DEBUG", "Build Phase", UVM_NONE)
    e = env::type_id::create("ENV", this);
  endfunction
  
  task run_phase(uvm_phase phase);
    `uvm_info("[DEBUG]", "Run phase", UVM_NONE)
    phase.drop_objection(this);
  endtask
endclass
//---------------------------------------
module tb();
  test t; 
  
  initial begin
    t = new("test", null);
    run_test();
  end
endmodule
