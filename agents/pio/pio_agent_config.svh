//
// Configuration file for pio agent
// 
`ifndef INCLUDED_pio_agent_config_svh
`define INCLUDED_pio_agent_config_svh

class pio_agent_config extends uvm_object;
  `uvm_object_utils(pio_agent_config)

  uvm_active_passive_enum active = UVM_ACTIVE;

  function new(string name="pio_agent_config");
    super.new(name);
  endfunction
endclass

`endif

