//
// Env for sap2 testbench
//

`ifndef INCLUDED_sap2_env_svh
`define INCLUDED_sap2_env_svh

class sap2_env extends uvm_env;

  `uvm_component_utils(sap2_env)

  sap2_env_config cfg;
  host_agent host_agent_inst;
  pio_agent pio_agent_0_inst;
  pio_agent pio_agent_1_inst;

  function new(string name="sap2_env", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    `uvm_info(get_full_name(), "Starting to build env", UVM_LOW)
    if(!uvm_config_db#(sap2_env_config)::get(this, "", "sap2_env_config", cfg)) begin
      `uvm_fatal("CONFIG_LOAD", "Cannot get() configuration sap2_env_config from uvm_config_db")
    end

    uvm_config_db#(host_agent_config)::set(this, "host_agent*", "host_agent_config", cfg.host_agent_cfg);
    host_agent_inst = host_agent::type_id::create("host_agent", this);
    if(!uvm_config_db#(virtual host_if)::get(this, "", "host_if", host_agent_inst.vif)) begin
      `uvm_fatal("CONFIG_LOAD", "Cannot get() interface host_if from uvm_config_db")
    end 

    uvm_config_db#(pio_agent_config)::set(this, "pio_agent_0*", "pio_agent_config", cfg.pio_agent_0_cfg);
    pio_agent_0_inst = pio_agent::type_id::create("pio_agent_0", this);
    if(!uvm_config_db#(virtual pio_if)::get(this, "", "pio_0_if", pio_agent_0_inst.vif)) begin
      `uvm_fatal("CONFIG_LOAD", "Cannot get() interface pio_if from uvm_config_db")
    end

    uvm_config_db#(pio_agent_config)::set(this, "pio_agent_1*", "pio_agent_config", cfg.pio_agent_1_cfg);
    pio_agent_1_inst = pio_agent::type_id::create("pio_agent_1", this);
    if(!uvm_config_db#(virtual pio_if)::get(this, "", "pio_1_if", pio_agent_1_inst.vif)) begin
      `uvm_fatal("CONFIG_LOAD", "Cannot get() interface pio_if from uvm_config_db")
    end

    `uvm_info(get_full_name(), "Completed env build", UVM_LOW)
  endfunction


endclass
`endif
