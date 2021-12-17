//UVM class factory
class driver;
  bit signal;
  bit [7:0] data;
  
  function new(input bit signal, input bit [7:0] data);
    this.signal=signal;
    this.data=data;
  endfunction
  
  task run();
    $display("[DRV] Signal value is: %0b, data value is: %0d", this.signal, this.data);
  endtask
  
endclass

class agent;
  
  driver drv;
  
  task run();
    drv=new(1'b1, 8'd89);
    drv.run();
  endtask
  
endclass

module tb;
  agent a;
  initial begin
    a=new();
    a.run();
  end
endmodule
