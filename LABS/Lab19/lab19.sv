//UVM_TLM_nonbloking
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

class producer extends umv_component;
  `uvm_component_utils(producer)
  
  transaction t;
  integer i;
  uvm_nonblocking_put_port#(transaction) send_port;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    send_port=name("send_port", this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    t=transaction::type_id::create("t");
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    for(i=0; i<10; i++) begin
      t.randomize();
      `uvm_info(get_name(), "Generating transaction", UVM_NONE)
      t.print(uvm_default_line_printer);
      send_port.try_put(t);
    end
    
    phase.drop_objection(this);
  endtask
  
endclass

class consumer extends uvm_component;
  `uvm_component_utils(consumer)
  
  uvm_nonblocking_put_imp#(transaction, consumer) recv_export;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    recv_export=new("recv_export", this);
  endfunction
  
  virtual function int try_put(input transaction t);
    `uvm_info(get_name(), "Receiving transaction", UVM_NONE)
    t.print(uvm_default_line_printer);
    return 1;
  endfunction
  
  function can_put();
  endfunction 
  
endclass

class env extends uvm_env;
  `uvm_component_utils(env)
  
  producer p;
  consumer c;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    p=producer::type_id::create("p", this);
    c=producer::type_id::create("c", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    p.send_port.connect(c.recv_export);
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
