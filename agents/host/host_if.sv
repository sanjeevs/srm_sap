//
// Host Interface
//

interface host_if(input clk, input reset);
  logic cmd_vld;
  logic [31:0] addr;
  logic [31:0] data_w;
  logic        rw;    // 0-Read, 1-Write
  logic [31:0] data_r;
  logic        rd_vld;

  parameter INPUT_SKEW=1;
  parameter OUTPUT_SKEW=1;

  clocking master_cb @(posedge clk); 
    default input #INPUT_SKEW output #OUTPUT_SKEW;
    input reset;
    output cmd_vld;
    output addr;
    output data_w;
    output rw;
    input  data_r;
    input  rd_vld;
  endclocking
  modport master(clocking master_cb);


  clocking slave_cb @(posedge clk);
    default input #INPUT_SKEW output #OUTPUT_SKEW;
    input reset;
    input cmd_vld;
    input addr;
    input data_w;
    input rw;
    output data_r;
    output rd_vld;
  endclocking 
  modport slave(clocking slave_cb);

endinterface
