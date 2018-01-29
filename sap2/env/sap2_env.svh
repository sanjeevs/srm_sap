//
// Env for sap2 testbench
//

`ifndef INCLUDED_sap2_env_svh
`define INCLUDED_sap2_env_svh

class sap2_env extends uvm_env;

  `uvm_component_utils(sap2_env)

  sap2_env_config cfg;
  host_agent host_agent_inst;
  sap2_host_bus_adapter host_bus_adapter;
  sap2_backdoor_adapter backdoor_adapter;

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

    host_bus_adapter = sap2_host_bus_adapter::type_id::create("host_bus_adapter", this);
    backdoor_adapter = sap2_backdoor_adapter::type_id::create("sap2_backdoor_adapter", this);

    `uvm_info(get_full_name(), "Completed env build", UVM_LOW)
  endfunction

  function void connect_phase(uvm_phase phase);
    host_bus_adapter.host_sqr = host_agent_inst.sqr;
    backdoor_adapter.prefix = "tb.dut";
  endfunction


endclass
`endif
