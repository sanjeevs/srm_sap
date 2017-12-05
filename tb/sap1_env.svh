//
// Env for sap1 testbench
//

`ifndef INCLUDED_sap1_env_svh
`define INCLUDED_sap1_env_svh

class sap1_env extends uvm_env;

  `uvm_component_utils(sap1_env)

  host_agent host_agent_inst;

  function new(string name="sap1_env", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    host_agent_inst = host_agent::type_id::create("host_agent", this);
    if(!uvm_config_db#(virtual host_if)::get(this, "", "host_if", host_agent_inst.vif)) begin
      `uvm_fatal("CONFIG_LOAD", "Cannot get() interface host_if from uvm_config_db")
    end
  endfunction

  function void connect_phase(uvm_phase phase);
  endfunction

endclass
`endif
