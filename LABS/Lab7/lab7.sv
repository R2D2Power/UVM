// UVM structure

typedef struct{
  bit[7:0] A;
  bit[7:0] B;
  bit[7:0] Z;
  bit sel;
}mux_struc;

	module tb;

      mux_struc MUX;

      initial begin
        MUX.A = 8'h57;
        MUX.B = 8'hA3;
        MUX.sel = 1'b1;
        MUX.Z = (MUX.sel)?(MUX.A):(MUX.B);
        $display("Output value of multiplexer is %oh", MUX.Z);
      end
    endmodule
