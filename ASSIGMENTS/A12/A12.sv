//Assignment 12
import uvm_pkg::*;
`include "uvm_macros.svh"

class transaction extends uvm_sequence_item;
  int data;
  
  function new(string name="");
    super.new(name);
  endfunction 
  
  `uvm_object_utils_begin(transaction)
  `uvm_field_int(data, UVM_DEC)
  `uvm_object_utils_end
  
endclass


class creator extends uvm_component; 
  
  `uvm_object_utils(creator)
  transaction t;
  
  uvm_blocking_put_port#(transaction) put_port;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    put_port = new("put_port", this);
  endfunction 
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    for(int i=0; i<10; i++) begin
      t = transaction::type_id::create("t");
      t,data = i*10;
      `uvm_info(get_name(), $sformatf("Data send:"), UVM_NONE);
      t.print(uvm_default_line_printer);
      put_port.put(t);
    end
    phase.drop_objection(this);
  endtask
endclass

class receptor extends uvm_component;
  `uvm_component_utils(receptor)
  
  uvm_blocking_get_port#(transaction) get_port;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    get_port = new("get_port", this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    transaction t;
    phase.raise_objection(this);
    for(int i=0; i<10; i++) begin
      get_port.get(t);
      `uvm_info(get_name(), $sformatf("Data received: "), UVM_NONE)
      t.print(uvm_default_line_printer);
    end
    phase.drop_objection(this);
  endtask
endclass

class env extends uvm_env;
  `uvm_component_utils(env)
  
  creator ctr;
  receptor rcp;
  
  uvm_tlm_fifo#(transaction) fifo;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ctr = creator::type_id::create("ctr", this);
    rcp = receptor::type_id::create("rcp", this);
    fifo = new("fifo", this, 10);
  endfunction 
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    ctr.put_port.connect(fifo.put_export);
    rcp.get_port.connect(fifo.get_export);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      if(fifo.is_full())begin
        `uvm_info(get_name(), "FIFO is full", UVM_NONE)
      end else begin
        `uvm_info(get_name(), "FIFO is not full", UVM_NONE)
      end
    end
  endtask
endclass

class test extends uvm_test;
  `uvm_component_utils(test)
  
  env e;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e = new::type_id::create("e", this);
  endfunction
  
endclass

module tb;
  initial begin
    run_test();
  end
endmodule
