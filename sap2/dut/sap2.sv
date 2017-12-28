//
// Top level of the design 'sap2'
//
module sap2(
  input logic clk,
  input logic reset,

  interface host_if
);

  sap1 #(32'ha000_0000, 32'h1000_0000) sap1_inst1(
    .clk(clk),
    .reset(reset),
    .host_if(host_if.slave));

  sap1 #(32'hb000_0000, 32'h1000_0000) sap1_inst2(
    .clk(clk),
    .reset(reset),
    .host_if(host_if.slave));
endmodule
