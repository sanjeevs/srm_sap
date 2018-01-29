//
// Env for blockA testbench
//

`ifndef INCLUDED_blockA_env_svh
`define INCLUDED_blockA_env_svh

class blockA_env extends uvm_env;

  `uvm_component_utils(blockA_env)

  blockA_env_config cfg;
  pio_agent pio_agent_inst;
  pio_bus_adapter pio_bus_adapter_inst;

  function new(string name="blockA_env", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    `uvm_info(get_full_name(), "Starting to build env", UVM_LOW)
    if(!uvm_config_db#(blockA_env_config)::get(this, "", "blockA_env_config", cfg)) begin
      `uvm_fatal("CONFIG_LOAD", "Cannot get() configuration blockA_env_config from uvm_config_db")
    end

    uvm_config_db#(pio_agent_config)::set(this, "pio_agent*", "pio_agent_config", cfg.pio_agent_cfg);
    pio_agent_inst = pio_agent::type_id::create("pio_agent", this);
    if(!uvm_config_db#(virtual pio_if)::get(this, "", "pio_if", pio_agent_inst.vif)) begin
      `uvm_fatal("CONFIG_LOAD", "Cannot get() interface pio_if from uvm_config_db")
    end

    pio_bus_adapter_inst = pio_bus_adapter::type_id::create("pio_bus_adapter", this);

    `uvm_info(get_full_name(), "Completed env build", UVM_LOW)
  endfunction

  function void connect_phase(uvm_phase phase);
    pio_bus_adapter_inst.pio_sqr = pio_agent_inst.sqr;
  endfunction


endclass
`endif
