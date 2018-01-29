`ifndef INCLUDED_blockA_env_config_svh
`define INCLUDED_blockA_env_config_svh

class blockA_env_config extends uvm_object;
  `uvm_object_utils(blockA_env_config)
  
  pio_agent_config pio_agent_cfg;

  function new(string name="blockA_env_config");
    super.new(name);
    pio_agent_cfg = pio_agent_config::type_id::create("pio_agent_cfg");
  endfunction
endclass

`endif
