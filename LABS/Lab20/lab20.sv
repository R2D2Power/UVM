//UVM_TLM_blocking_get  -----------> si compilo
import uvm_pkg::*;
`include "uvm_macros.svh"

class transaction extends uvm_sequence_item;
  rand logic[3:0] a;
  rand logic[7:0] b;
  
  function new (string name="");
    super.new(name);
  endfunction
  
  `uvm_object_utils_begin(transaction)
  `uvm_field_int(a, UVM_DEFAULT)
  `uvm_field_int(b, UVM_DEFAULT)
  `uvm_object_utils_end
  
endclass

class consumer_int extends uvm_component;
  `uvm_component_utils(consumer_int)
    
    uvm_blocking_get_port#(transaction)get_port;
    function new(string name, uvm_component parent);
      super.new(name, parent);
      get_port=new("get_port", this);
    endfunction
    
    task run_phase(uvm_phase phase);
      transaction txn;
      for(int i=0; i<10; i++)begin
        get_port.get(txn);
        `uvm_info(get_name(), "Recieved transaction", UVM_NONE)
        txn.print(uvm_default_line_printer);
      end
    endtask
endclass

class producer_target extends uvm_component;
  `uvm_component_utils(producer_target)
  
  uvm_blocking_get_imp#(transaction, producer_target) get_export;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    get_export=new("get_export", this);
  endfunction
  
  task get(output transaction t);
    transaction t_temp=transaction::type_id::create("t_temp");
    assert(t_temp.randomize());
    `uvm_info(get_name(), "Sending trasaction", UVM_NONE)
    t_temp.print(uvm_default_line_printer);
    t=t_temp;
  endtask
  
endclass

class env extends uvm_env;
  `uvm_component_utils(env)
  
  consumer_int cons;
  producer_target prod;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cons=consumer_int::type_id::create("cons", this);
    prod=producer_target::type_id::create("prod", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    cons.get_port.connect(prod.get_export);
  endfunction
  
endclass

class test extends uvm_test;
  `uvm_component_utils(test)
  
  env e;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e=env::type_id::create("e", this);
  endfunction
endclass

module tb;
  initial begin
    run_test();
  end
endmodule
