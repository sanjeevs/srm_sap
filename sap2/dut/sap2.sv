//
// Top level of the design 'sap2'
//
module sap2(
  input logic clk,
  input logic reset,

  interface host_if
);

  host_if host_inst1_if (.clk(clk), .reset(reset));
  host_if host_inst2_if (.clk(clk), .reset(reset));

  // Wire the interfaces.
  assign host_inst1_if.cmd_vld = host_if.cmd_vld;
  assign host_inst1_if.addr = host_if.addr;
  assign host_inst1_if.data_w = host_if.data_w;
  assign host_inst1_if.rw = host_if.rw;
  
  assign host_inst2_if.cmd_vld = host_if.cmd_vld;
  assign host_inst2_if.addr = host_if.addr;
  assign host_inst2_if.data_w = host_if.data_w;
  assign host_inst2_if.rw = host_if.rw;

  assign host_if.data_r = host_inst1_if.rd_vld ? host_inst1_if.data_r
                                               : host_inst2_if.data_r;
  assign host_if.rd_vld = host_inst1_if.rd_vld | host_inst2_if.rd_vld;

  sap1 #(32'ha000_0000, 32'h1000_0000) sap1_0(
    .clk(clk),
    .reset(reset),
    .host_if(host_inst1_if.slave));

  sap1 #(32'hb000_0000, 32'h1000_0000) sap1_1(
    .clk(clk),
    .reset(reset),
    .host_if(host_inst2_if.slave));
endmodule
  
