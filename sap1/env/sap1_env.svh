//
// Env for sap1 testbench
//

`ifndef INCLUDED_sap1_env_svh
`define INCLUDED_sap1_env_svh

class sap1_env extends uvm_env;

  `uvm_component_utils(sap1_env)

  sap1_env_config cfg;
  host_agent host_agent_inst;
  pio_agent pio_agent_inst;

  function new(string name="sap1_env", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    `uvm_info(get_full_name(), "Starting to build env", UVM_LOW)
    if(!uvm_config_db#(sap1_env_config)::get(this, "", "sap1_env_config", cfg)) begin
      `uvm_fatal("CONFIG_LOAD", "Cannot get() configuration sap1_env_config from uvm_config_db")
    end

    uvm_config_db#(host_agent_config)::set(this, "host_agent*", "host_agent_config", 
                                           cfg.host_agent_cfg);
    host_agent_inst = host_agent::type_id::create("host_agent", this);
    if(!uvm_config_db#(virtual host_if)::get(this, "", "host_if", host_agent_inst.vif)) begin
      `uvm_fatal("CONFIG_LOAD", "Cannot get() interface host_if from uvm_config_db")
    end

    uvm_config_db#(pio_agent_config)::set(this, "pio_agent*", "pio_agent_config", cfg.pio_agent_cfg);
    pio_agent_inst = pio_agent::type_id::create("pio_agent", this);
    if(!uvm_config_db#(virtual pio_if)::get(this, "", "pio_if", pio_agent_inst.vif)) begin
      `uvm_fatal("CONFIG_LOAD", "Cannot get() interface pio_if from uvm_config_db")
    end


    `uvm_info(get_full_name(), "Completed env build", UVM_LOW)
  endfunction


endclass
`endif
