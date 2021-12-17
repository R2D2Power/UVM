//UVM TLM blocking
import uvm_pkg::*;
`include "uvm_macros.svh"

class creator extends uvm_component;
`uvm_component_utils(creator)

  logic [7:0] v1 = 8'h3A;
  logic [3:0] v2 = 4'h9;
  logic [31:0] v3 = 32'hA5F2CA45;
  

  uvm_blocking_put_port # (logic[7:0]) put_port1;
  uvm_blocking_put_port # (logic[3:0]) put_port2;
  uvm_blocking_put_port # (logic[31:0]) put_port3;
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
    put_port1=new("put_port1", this);
    put_port2=new("put_port2", this);
    put_port3=new("put_port3", this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info(get_name(), $sformatf("Generating and sending data port1: %0h, port2: %0h, and port3: %0h", v1, v2, v3), UVM_NONE)
    put_port1.put(v1);
    put_port2.put(v2);
    put_port3.put(v3);
    phase.drop_objection(this);
  endtask
  
endclass

class receptor extends uvm_component;
  `uvm_component_utils(receptor)
  `uvm_blocking_put_imp_dec1(_1)
  `uvm_blocking_put_imp_dec1(_2)
  `uvm_blocking_put_imp_dec1(_3)
  
  uvm_blocking_put_imp_1 #(logic[7:0], receptor) get_port1;
  uvm_blocking_put_imp_2 #(logic[3:0], receptor) get_port2;
  uvm_blocking_put_imp_3 #(logic[31:0], receptor) get_port3;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    get_port1=new("get_port1", this);
    get_port2=new("get_port2", this);
    get_port3=new("get_port3", this);
  endfunction 
  
  virtual task put_1(logic[7:0]val1);
    `uvm_info("receptor:port1", $sformatf("The data recieved is: %0h", val1), UVM_NONE);
  endtask
  
  virtual task put_2(logic[3:0]val2);
    `uvm_info("receptor:port2", $sformatf("The data received is: %oh", val2), UVM_NONE);
  endtask
  
  virtual task put_3(logic[31:0]val3);
    `uvm_info("receptor:port3", $sformatf("The data received is: %0h", val3), UVM_NONE);
  endtask
  
endclass

class test extends uvm_test;
  `uvm_component_utils(test)
  
  creator c;
  receptor r; 
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    c=creator::type_id::create("c", this);
    r=receptor::type_id::create("r", this);
  endfunction 
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    c.put_port1.connect(r.get_port1);
    c.put_port2.connect(r.get_port2);
    c.put_port3.connect(r.get_port3);
  endfunction
  
endclass

module tb;
  initial begin
    run_test();
  end
endmodule
