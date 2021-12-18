//UVM_VIF_agent_rt----------->compila
interface clkrstn_if();
  bit clk;
  bit rstn;
endinterface

interface input_if(input clk, rstn);
  bit[3:0]a;
  bit[3:0]b;
endinterface

interface config_if(input clk, rstn);
  bit mode;
  bit en;
endinterface

interface output_if(input clk, rstn);
  logic [4:0]z;
  logic z_vd;
endinterface

module add_sub4(
  input logic clk,
  input logic rstn,
  input logic mode,
  input logic en,
  input logic [3:0]a,
  input logic [3:0]b,
  output logic [4:0]z,
  output logic z_vd
);

  always_ff@(posedge clk, negedge rstn)begin
    if(!rstn)
      z<='0;
    else if(en)
      z<=(mode)?(a+b):(a-b);
  end

  always_ff@(posedge clk, negedge rstn)begin
    if(!rstn)
      z_vd<='0;
    else
      z_vd=en;
  end
endmodule
