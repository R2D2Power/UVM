//UVM verbosity

import uvm_pkg::*;

`include "uvm_macros.svh"

class disp_comp extends uvm_component;
  `uvm_component_utils(disp_comp)

  rand bit[15:0] data;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    `uvm_info(get_name(), $sformatf("The value of data members is %0x", data), UVM_FULL)
  endtask

endclass

	module tb;
      disp_comp disp;
      int level;

      initial begin
        disp = disp_comp::type_id::create("disp", null);
        disp.set_report_verbosity_level(UVM_HIGH);
        level = disp.get_report_verbosity_level;

        `uvm_info("INFO", $sformatf("The verbosity level is: %0d", level), UVM_NONE);
        disp.randomize();
        run_test();
      end
    endmodule
