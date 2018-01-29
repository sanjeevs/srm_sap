//
// Block level testbench
//

module tb();
  import uvm_pkg::*;

  bit reset;
  bit clk;

  clkgen_if clkgen_if();
  assign clk = clkgen_if.clk;

  pio_if pio_if(.clk(clk), .reset(reset));

  blockA dut(.clk(clk),
           .reset(reset),
           .pio_if(pio_if.slave));


  initial begin
    reset = 1'b1;
    repeat(2) @(posedge clk);
    reset = 1'b0;
  end

  initial begin
    uvm_config_db#(virtual pio_if)::set(uvm_root::get(), "*", "pio_if", pio_if);
    uvm_config_db#(virtual clkgen_if)::set(uvm_root::get(), "*", "clkgen_if", clkgen_if);
  end

  initial begin
    run_test();
  end

  initial begin
    $vcdpluson();
  end
endmodule
