//
// BlockA
// Contains a single register and a 1K table.
//

module blockA(
  input logic clk,
  input logic reset,

  interface pio_if
);

  logic [31:0] r1;
  logic [31:0] t1[1023:0];

  always@(posedge clk) begin
    if(reset) begin
      r1 <= 32'd0;
    end
    else if(pio_if.cmd_vld && pio_if.rw) begin
      if(pio_if.addr[12]) begin
	// Reg
        r1 <= pio_if.data_w;
      end 
      else begin
	// Table
        t1[pio_if.addr[9:0]] <= pio_if.data_w;
      end
    end
  end

  // Table t1 is at offset 0 and r1 is at offset 0x1000
  always@(posedge clk)
    if(pio_if.cmd_vld && !pio_if.rw) begin
      if(pio_if.addr[12]) begin
        // Reg
        pio_if.data_r <= r1;
        pio_if.rd_vld <= 1'b1;
      end
      else begin
        // Table
        pio_if.data_r <= t1[pio_if.addr[9:0]];
        pio_if.rd_vld <= 1'b1;
      end
    end
    else begin
      pio_if.rd_vld <= 1'b0;
    end

endmodule
