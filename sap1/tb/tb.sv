//
// Top level testbench
//

module tb();
  import uvm_pkg::*;

  bit reset;
  bit clk;

  clkgen_if clkgen_if();
  assign clk = clkgen_if.clk;

  host_if host_if(.clk(clk), .reset(reset));

  sap1 #(32'ha000_0000, 32'h1000_0000) dut(.clk(clk),
           .reset(reset),
           .host_if(host_if.slave));


  initial begin
    reset = 1'b1;
    repeat(2) @(posedge clk);
    reset = 1'b0;
  end

  initial begin
    uvm_config_db#(virtual host_if)::set(uvm_root::get(), "*", "host_if", host_if);
    uvm_config_db#(virtual clkgen_if)::set(uvm_root::get(), "*", "clkgen_if", clkgen_if);
  end

  initial begin
    run_test();
  end

  initial begin
    $vcdpluson();
  end
endmodule
