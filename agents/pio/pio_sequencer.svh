// 
// Generic uvm sequencer templated on pio_xact.
//
`ifndef INCLUDED_pio_sequencer
`define INCLUDED_pio_sequencer

class pio_sequencer extends uvm_sequencer#(pio_xact);
  `uvm_component_utils(pio_sequencer)

  function new(string name="pio_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

endclass

`endif

