//
// Top level of the design 'sap1'
//
module sap1(
  input logic clk,
  input logic reset,

  interface host_if
);

  pio_if pio_if(.clk(clk), .reset(reset));

  host host (
    .clk(clk),
    .reset(reset),
    .host_if(host_if.slave),
    .pio_if(pio_if.master));


  blockX blockX(
    .clk(clk),
    .reset(reset),
    .pio_if(pio_if.slave));

endmodule
