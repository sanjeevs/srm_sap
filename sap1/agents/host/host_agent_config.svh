//
// Configuration file for host agent
//
`ifndef INCLUDED_host_agent_config_svh
`define INCLUDED_host_agent_config_svh

class host_agent_config extends uvm_object;
  `uvm_object_utils(host_agent_config)

  uvm_active_passive_enum active = UVM_ACTIVE;

  function new(string name="host_agent_config");
    super.new(name);
  endfunction
endclass

`endif

