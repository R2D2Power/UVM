import uvm_pkg::*;
`include "uvm_macros.svh"

class transaction extends uvm_sequence_item;
  
  rand bit[7:0] a,b;
  
  `uvm_object_utils_begin(transaction)
  `uvm_field_int(a, UVM_DEFAULT)
  `uvm_field_int(b, UVM_DEFAULT)
  `uvm_object_utils_end
  
  function new(string name="");
    super.new(name);
  endfunction 
  
  function void do_copy(uvm_object rhs);
    transaction t;
    assert($cast(t, rhs));
    super.do_copy(rhs);
    a=t.a;
    b=t.b;
  endfunction
  
endclass

class test extends uvm_test;
  `uvm_component_utils(test);
  
  transaction t1, t2, t3;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction 
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    t1=transaction::type_id::create("t1");
    t2=transaction::type_id::create("t2");
  endfunction
  
  virtual task run();
    t1.randomize();
    t1.print(uvm_default_line_printer);
    t2.copy(t1);
    t2.print(uvm_default_line_printer);
    $cast(t3, t2.clone());
    t3.print(uvm_default_line_printer);
  endtask
  
endclass

module tb;
  initial begin
    run_test();
  end
endmodule
