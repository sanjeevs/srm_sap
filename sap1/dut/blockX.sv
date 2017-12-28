//
// BlockX of sap1
// Contains a single register and a 1K table.
//

module blockX(
  input logic clk,
  input logic reset,

  interface pio_if
);

  logic [31:0] r1;
  logic [31:0] t1[1023:0];

  always@(posedge clk)
    if(pio_if.cmd_vld && pio_if.rw) begin
      if(!pio_if.addr[15]) begin
        r1 <= pio_if.data_w;
      end 
      else begin
        t1[pio_if.addr[7:0]] <= pio_if.data_w;
      end
    end

  // Table t1 is at offset 0 and r1 is at offset 0x1000
  always@(posedge clk)
    if(pio_if.cmd_vld && !pio_if.rw) begin
      if(pio_if.addr[12]) begin
        pio_if.data_r <= r1;
        pio_if.rd_vld <= 1'b1;
      end
      else begin
        pio_if.data_r <= t1[pio_if.addr[9:0]];
        pio_if.rd_vld <= 1'b1;
      end
    end
    else begin
      pio_if.rd_vld <= 1'b0;
    end

endmodule
