import uvm_pkg::*;

`include "uvm_macros.svh"

	module tb;
      
      initial begin
        `uvm_info("TEST", "Here you type your message", UVM_NONE);
        `uvm_warning("TEST", "Here you type your warning report text");
        `uvm_error("TEST", "Here you type your error text");
        `uvm_fatal("TEST", "Here you type your fatal report text");
        `uvm_info("TEST", "This report won't appear since fatal report exits simulation", UVM_NONE);
      end
    endmodule

