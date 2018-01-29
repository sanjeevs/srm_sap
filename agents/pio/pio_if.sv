//
// Pio Interface
// cmd_vld is a pulse that issues either a read (rw=0) or a write (rw=1).
// For a write the data_w bus is valid and it completes immediately.
// For a read the data_r is sampled when the receiver pulses rd_vld.
//
interface pio_if(input clk, input reset);
  logic cmd_vld;      // 1- command valid.
  logic [15:0] addr;  // Address valid with cmd_vld
  logic [31:0] data_w;// Write data valid with cmd_vld and rw=1
  logic        rw;    // 0-Read, 1-Write
  logic [31:0] data_r;// Return read data.
  logic        rd_vld;// Valid read data on the bus.

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
