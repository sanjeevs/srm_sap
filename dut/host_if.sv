//
// Host Interface
//

interface host_if;
  logic cmd_vld;
  logic [31:0] addr;
  logic [31:0] data_w;
  logic        rw;    // 0-Read, 1-Write
  logic [31:0] data_r;
  logic        rd_vld;

  modport master (
    output cmd_vld,
    output addr,
    output data_w,
    output rw,
    input  data_r,
    input  rd_vld
  );


  modport slave (
    input cmd_vld,
    input addr,
    input data_w,
    input rw,
    output data_r,
    output rd_vld
  );

endinterface
