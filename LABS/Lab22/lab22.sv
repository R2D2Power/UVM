//UVM factory override----------> compila
import uvm_pkg::*;
`include "uvm_macros.svh"

class operation extends uvm_object;
  `uvm_object_utils(operation)
  
  int x=16, y=64;
  
  function new(string name="");
    super.new(name);
  endfunction
  
  virtual function void op();
    `uvm_info(get_name(), $sformatf("The result of sum is %0d", x+y), UVM_NONE)
  endfunction
endclass

class operation_child extends operation;
  `uvm_object_utils(operation_child)
  
  function new(string name="");
    super.new(name);
  endfunction
  
  virtual function void op();
    `uvm_info(get_name(), $sformatf("The result of multiplication is %od", x+y), UVM_NONE)
  endfunction
endclass

class env extends uvm_env;
  `uvm_component_utils(env)
  
  operation op_parent;
  operation_child op_child;
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction 
  
  function void print();
    op_parent=operation::type_id::create("op_parent");
	op_child=operation_child::type_id::create("op_child");
    op_parent.op();
    op_child.op();
  endfunction
  
endclass

class test extends uvm_test;
  `uvm_component_utils(test)
  env e;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    uvm_factory factory = uvm_factory::get();
    super.build_phase(phase);
    e=env::type_id::create("e", this);
    e.print();
    set_type_override_by_type(operation::get_type(), operation_child::get_type());
    e.print;
    factory.print();
  endfunction
endclass

module tb;
  initial begin
    run_test();
  end
endmodule
