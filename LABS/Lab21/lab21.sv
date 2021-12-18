//UVM_config_object_1---------->compila
import uvm_pkg::*;
`include "uvm_macros.svh"

class env_cfg_obj extends uvm_object;
  uvm_active_passive_enum is_active=UVM_ACTIVE;
  logic enable_tracker = 1;
  `uvm_object_utils(env_cfg_obj)
  
  function new(string name="");
    super.new(name);
  endfunction
endclass

class env extends uvm_env;
  `uvm_component_utils(env)
  
  env_cfg_obj e_cfg_obj;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(env_cfg_obj)::get(this, "", "e_cfg_obj", e_cfg_obj))
      `uvm_fatal(get_name(), "Unable to get e_cfg_obj")
      `uvm_info(get_name(), $sformatf("Received enviroment configuration object %b, %b", e_cfg_obj.is_active, e_cfg_obj.enable_tracker), UVM_NONE)
      e_cfg_obj.print();
  endfunction
  
endclass

class test extends uvm_test;
  `uvm_component_utils(test)
  env_cfg_obj e_cfg_obj;
  env e;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction 
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e_cfg_obj = env_cfg_obj::type_id::create("e_cfg_obj");
    e=env::type_id::create("e", this);
    uvm_config_db#(env_cfg_obj)::set(this, "e", "e_cfg_obj", e_cfg_obj);
  endfunction
  
endclass

module tb;
  initial begin
    run_test();
  end
endmodule
