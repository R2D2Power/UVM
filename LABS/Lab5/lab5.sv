//UVM sformatf

import uvm_pkg::*;

`include "uvm_macros.svh"

	module tb;

      reg[7:0] var1 = 8'b10110001;
      integer integer1 = 17;
      shortreal float1 = 16.3;

      initial begin
        `uvm_info("PRINT", $sformatf("Binary value of var1: %0b and integer1: %0b", var1, integer1), UVM_NONE);
        `uvm_info("PRINT", $sformatf("Decimal value of var1: %0d and integer1: %od", var1, integer1), UVM_NONE);
        `uvm_warning("PRINT", $sformatf("Hexadecimal value of var1: %0h and integer1: %Oh", var1, integer1));
        `uvm_warning("PRINT", $sformatf("Value of float1: %2.3f", float1));

      end
    endmodule
