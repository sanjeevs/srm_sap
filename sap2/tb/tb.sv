//
// Top level SAP2 testbench
//

module tb();
  import uvm_pkg::*;

  bit reset;
  bit clk;

  clkgen_if clkgen_if();
  assign clk = clkgen_if.clk;

  host_if host_if(.clk(clk), .reset(reset));

  bind pio_wrapper_if pio_wrapper_bind pio_wrapper_bind (
    .clk(clk),
    .reset(reset),
    .cmd_vld_net(cmd_vld),
    .addr_net(addr),
    .data_w_net(data_w),
    .rw_net(rw),
    .data_r(data_r),
    .rd_vld(rd_vld));

  virtual pio_if pio_0_if = sap2.sap1_0.blockA.pio_wrapper_bind.intf;
  virtual pio_if pio_1_if = sap2.sap1_1.blockA.pio_wrapper_bind.intf;

  sap2 dut(.clk(clk),
           .reset(reset),
           .host_if(host_if.slave));


  initial begin
    reset = 1'b1;
    repeat(2) @(posedge clk);
    reset = 1'b0;
  end

  initial begin
    uvm_config_db#(virtual host_if)::set(uvm_root::get(), "*", "host_if", host_if);
    uvm_config_db#(virtual pio_if)::set(uvm_root::get(), "*", "pio_0_if", pio_0_if);
    uvm_config_db#(virtual pio_if)::set(uvm_root::get(), "*", "pio_1_if", pio_1_if);
    uvm_config_db#(virtual clkgen_if)::set(uvm_root::get(), "*", "clkgen_if", clkgen_if);
  end

  initial begin
    run_test();
  end

`ifdef VCS
  initial begin
    $vcdpluson();
  end
`endif
endmodule
