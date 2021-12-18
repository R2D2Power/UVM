//UVM VIF rtl-------------->compila
interface basic_if();
  bit[3:0]a;
  bit[3:0]b;
  logic[4:0]z;
  
endinterface

module add4(
  input logic [3:0]a,
  input logic [3:0]b,
  output logic [4:0]z
);
  assign z = a+b;
  
endmodule
