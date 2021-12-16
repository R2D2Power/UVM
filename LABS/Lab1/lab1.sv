//UVM Info
import uvm_pkg::*;

`include "uvm_macros.svh"

module tb;
  initial begin
    `uvm_info("DEMO", "Hello world", UVM_NONE)
  end
endmodule
