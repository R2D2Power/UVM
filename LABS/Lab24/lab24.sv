//UVM VIF 1 verif -----------> no compila
import uvm_pkg::*;
`include "uvm_macros.svh"

class driver extends uvm_driver;
  `uvm_component_utils(driver)
  
  virtual basic_if basic_vif;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void assign_vif(virtual basic_if basic_vif);
    this.basic_vif=basic_vif;
  endfunction
  
  task run_phase(uvm_phase phase);
    basic_vif.a='0;
    basic_vif.b='0;
    for(int i=0; i<10; i++)begin
      `uvm_info(get_name(), "Generating stimulus", UVM_NONE)
      basic_vif.a=$random();
      basic_vif.b=$random();
      `uvm_info(get_name(), $sformatf("issuing signal to DUT: a:%0d, b:%0d", basic_vif.a, basic_vif.b), UVM_NONE)
    end
  endtask
endclass

class test extends uvm_test;
  `uvm_component_utils(test)
  virtual basic_if basic_vif;
  driver drv;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction 
  
  function void build_phase(uvm_phase phase);
    drv=driver::type_id::create("drv", this);
    if(!uvm_config_db #(virtual basic_if)::get(this,  "", "basic_if", basic_vif))
      `uvm_fatal(get_name(), "Failed to get basic_vif")
      
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.assign_vif(basic_vif);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    phase.drop_objection(this);
  endtask
endclass

module tb;
  basic_if basic_if_inst();
  add4 DUT(a.(basic_if_inst.a), .b(basic_if_inst.b), .z(basic_if_inst.z));
  initial begin
    uvm_config_db#(virtual basic_if)::set(null, "", "basic_if", basic_if_inst);
    run_test();
  end
  
  initial begin
    forever begin
      `uvm_info("TESTBENCH", $sformatf("Result from adder is: %0d", basic_if_inst.z), UVM_NONE)
    end
  end
endmodule
