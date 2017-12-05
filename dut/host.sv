//
// Host block of sap1
//

module host(
  input logic clk,
  input logic reset,

  interface host_if,
  interface pio_if
);

  logic [31:0] base_address;
  logic [31:0] range;

  // SAP1 address decode is from 0xA000_0000 to 0xB000_0000
  always @(posedge clk) 
    if(reset) begin
      base_address = 32'hA000_0000;
      range = 32'h1000_0000;
    end

  logic valid_dec;
  assign valid_dec = (host_if.addr >= base_address)
                    && (host_if.addr < (base_address + range));

  logic [15:0] pio_addr;
  logic [31:0] pio_data_w;
  logic pio_rw;
  logic pio_cmd_vld;

  always @(posedge clk) 
    if(reset == 1'b1) begin
      pio_cmd_vld <= 1'b0;
    end
    else begin
      if(host_if.cmd_vld && valid_dec) begin 
        pio_addr <= host_if.addr[15:0];
        pio_data_w <= host_if.data_w;
        pio_rw <= host_if.rw;
        pio_cmd_vld <= host_if.cmd_vld;
      end
    end

  assign pio_if.addr = pio_addr;
  assign pio_if.data_w = pio_data_w;
  assign pio_if.rw = pio_rw;
  assign pio_if.cmd_vld = pio_cmd_vld;

  logic pio_rd_vld;
  logic [31:0] pio_data_r;
  always @(posedge clk) begin 
    pio_rd_vld <= pio_if.rd_vld;
    pio_data_r <= pio_if.data_r;
  end

  assign host_if.rd_vld = pio_rd_vld;
  assign host_if.data_r = pio_data_r;

endmodule
