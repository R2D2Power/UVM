class Op_parent;
  bit[15:0];
  
  task run(input bit[7:0]A,B);
  	Z=A*B;
  	$display("[PARENT] Output value of must is: %0d, size: %0d", Z, $size(Z));
  endtask
    
endclass

class Op_child extends Op_parent;
  bit[8:0]Z=0;
  task run(input bit [7:0]A,B);
    Z=A+B;
    $display("[CHILD] Output value of sum is: %0d, size: %0d", Z, $size(Z));
  endtask
endclass

	module tb;
      
      Op_parent parent;
      Op_parent child;
      
      initial begin
        child = new();
        parent = child;
        parent.run(8'h03, 8'h12);
        
      end
      
    endmodule
