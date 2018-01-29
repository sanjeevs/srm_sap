//
// Top level of the design 'sap1'
//
module sap1 (
  input logic clk,
  input logic reset,
  interface host_if
);

  parameter HOST_BASE=32'h0;
  parameter HOST_SIZE=32'h1000_0000;

  pio_if pio_if(.clk(clk), .reset(reset));

  host #(HOST_BASE, HOST_SIZE) host (
    .clk(clk),
    .reset(reset),
    .host_if(host_if.slave),
    .pio_if(pio_if.master));


  blockA blockA(
    .clk(clk),
    .reset(reset),
    .pio_if(pio_if.slave));

endmodule
