//
// Top level testbench
//

module tb();
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  bit clk;
  bit reset;

  assign #1 clk = ~clk;

  host_if host_if();

  sap1 dut(.clk(clk),
           .reset(reset),
           .host_if(host_if.slave));


  initial begin
    reset = 1'b1;
    repeat(2) @(posedge clk);
    reset = 1'b0;
  end

  initial begin
    uvm_config_db#(virtual host_if)::set(uvm_root::get(), "*", "host_if", host_if);
  end

  initial begin
    run_test();
  end
endmodule
