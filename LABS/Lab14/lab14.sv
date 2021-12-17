//Transaction extends from uvm sequence item

import uvm_pkg::*;
`include "uvm_macros.svh"

class transaction extends uvm_sequence_item;
  rand bit[31:0] data1, data2;
  logic[23:0] res;
  logic res_en;

  `uvm_object_utils_begin(transaction)
  `uvm_field_int(data1, UVM_HEX)
  `uvm_field_int(data2, UVM_HEX)
  `uvm_field_int(res, UVM_HEX)
  `uvm_field_int(res_en, UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name="");
    super.new(name);
  endfunction

endclass

module tb;
  transaction t;

  initial begin
    t=transaction::type_id::create("t");
    t.randomize with{data1 < 'hFFFF_0000; data2 > 'hFFFF_0000;};
    t.res='0;
    t.res_en=1'b1;
    t.print(uvm_default_line_printer);
  end
endmodule
