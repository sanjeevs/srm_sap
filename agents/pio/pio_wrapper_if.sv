//
// Wrapper for pio_if.
// Uses supply0/1 to force the RTL net. use this interface
// for testbenches where the RTL is also driving the interface.
//

  logic cmd_vld;      // 1- command valid.
  logic [15:0] addr;  // Address valid with cmd_vld
  logic [31:0] data_w;// Write data valid with cmd_vld and rw=1
  logic        rw;    // 0-Read, 1-Write
  logic [31:0] data_r;// Return read data.
  logic        rd_vld;// Valid read data on the bus.

interface pio_wrapper_if(input clk,
                         input reset,
                         output wire cmd_vld_net,
                         output wire [15:0] addr_net,
                         output wire [31:0] data_w_net,
                         output wire rw_net,
                         input [31:0] data_r,
                         input  rd_vld);

  // Wrap the pio interface
  pio_if intf(.*);

  assign intf.data_r = data_r;
  assign intf.rd_vld = rd_vld;

  wire active = (intf.cmd_vld === 1'b1) ? 1'b1 : 1'b0;

  assign (supply1, supply0) cmd_vld_net = active ? intf.cmd_vld : 1'bz;
  assign (supply1, supply0) addr_net = active ? intf.addr : 16'hz;
  assign (supply1, supply0) data_w_net = active ? intf.data_w : 32'hz;
  assign (supply1, supply0) rw_net = active ? intf.rw : 1'bz;


endinterface
