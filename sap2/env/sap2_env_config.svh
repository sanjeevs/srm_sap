`ifndef INCLUDED_sap2_env_config_svh
`define INCLUDED_sap2_env_config_svh

class sap2_env_config extends uvm_object;
  `uvm_object_utils(sap2_env_config)
  
  host_agent_config host_agent_cfg;
  pio_agent_config pio_agent_cfg;

  function new(string name="sap2_env_config");
    super.new(name);
    host_agent_cfg = host_agent_config::type_id::create("host_agent_cfg");
    pio_agent_cfg = pio_agent_config::type_id::create("pio_agent_cfg");
  endfunction
endclass

`endif
