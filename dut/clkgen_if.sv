// Package for wrapping the clock signal

interface clkgen_if;
  bit clk;
  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
  end
endinterface
