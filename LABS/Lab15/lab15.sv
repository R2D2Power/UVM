//To create transaction item
//
import uvm_pkg::*;
`include "uvm_macros.svh"

class transaction extends uvm_sequence_item;
  
  rand bit clk, wr, en;
  rand bit[31:0] data_in;
  logic[11:0] addr;
  logic[31:0]data_out;
  
  `uvm_object_utils_begin(transaction)
  `uvm_field_int(clk, UVM_DEFAULT)
  `uvm_field_int(wr, UVM_DEFAULT)
  `uvm_field_int(data_in, UVM_DEFAULT)
  `uvm_field_int(addr, UVM_DEFAULT)
  `uvm_field_int(data_out, UVM_DEFAULT)
  `uvm_object_utils_end
  
  function new(string name="");
    super.new(name);
  endfunction
  
endclass

class test extends uvm_test;
  `uvm_component_utils(test);
  
  transaction txn;
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction 
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    txn=transaction::type_id::create("txn");
  endfunction 
  
  task run_phase(uvm_phase phase);
    tcn.randomize();
    txn.print(uvm_default_line_printer);
  endtask
  
endclass

module tb;
  initial begin 
    run_test();
  end
endmodule
