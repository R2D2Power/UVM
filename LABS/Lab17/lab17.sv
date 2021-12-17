//Producer and consumer of transactions
import uvm_pkg::*;
`include "uvm_macros.svh"

class transaction extends uvm_sequence_item;
  rand bit[31:0]v1;
  rand bit[31:0]v2;
  
  function new(string name="");
    super.new(name);
  endfunction 
  
  `uvm_object_utils_begin(transaction)
  `uvm_field_int(v1, UVM_DEFAULT)
  `uvm_field_int(v2, UVM_DEFAULT)
  `uvm_object_utils_end
  
endclass

class producer extends uvm_component;
  `uvm_component_utils(producer)
  
  transaction txn;
  uvm_blocking_put_port #(transaction) prod_port;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    prod_port = new("prod_port", this);
  endfunction
      
   virtual function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     txn=transaction::type_id::create("txn");
   endfunction
      
   task run_phase(uvm_phase phase);
     txn.randomize();
     `uvm_info(get_name(), "Generating transaction", UVM_NONE)
     txn.print();
     prod_port.put(txn);
   endtask
endclass

class consumer extends uvm_component;
  `uvm_component_utils(consumer)
  
  uvm_blocking_put_imp #(transaction, consumer)cons_export;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    cons_export = new("cons_export", this);
  endfunction 
  
  virtual task put(input transaction txn);
    `uvm_info(get_name(), "Receiving transaction", UVM_NONE)
    txn.print();
  endtask
  
endclass

class env extends uvm_env;
  `uvm_component_utils(env)
  
  producer prod;
  consumer cons;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    prod=producer::type_id::create("prod", this);
    cons=consumer::type_id::create("cons", this);
  endfunction 
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    prod.prod_port.connect(cons.cons_export);
  endfunction
  
endclass

class test extends uvm_test;
  `uvm_component_utils(test)
  env e;
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e=env::type_id::create("e", this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    phase.drop_objection(this);
  endtask
endclass

module tb;
  initial begin
    run_test();
  end
endmodule
