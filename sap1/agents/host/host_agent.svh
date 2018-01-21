`ifndef INCLUDED_host_agent 
`define INCLUDED_host_agent
class host_agent extends uvm_agent;
  
  `uvm_component_utils(host_agent)

  virtual host_if vif;

  // Component members
  uvm_analysis_port #(host_xact) ap;
  host_driver drv;
  host_sequencer sqr;
  host_agent_config cfg;

  // Standard UVM methods
  extern function new(string name="host_agent", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

endclass

function host_agent::new(string name="host_agent", uvm_component parent = null);
  super.new(name, parent);
endfunction

function void host_agent::build_phase(uvm_phase phase);
  `uvm_info(get_full_name(), "Starting to build host_agent", UVM_NONE)
  if(!uvm_config_db#(host_agent_config)::get(this, "", "host_agent_config", cfg)) begin
    `uvm_fatal("CONFIG_LOAD", "Cannot get() host_agent_config from config_db")
  end
  if(cfg.active == UVM_ACTIVE) begin
    drv = host_driver::type_id::create("host_driver", this);
    sqr = host_sequencer::type_id::create("host_sequencer", this);
  end
endfunction

function void host_agent::connect_phase(uvm_phase phase);
  if(cfg.active == UVM_ACTIVE) begin
    `uvm_info(get_full_name(), "Connecting up host_agent", UVM_NONE)
    drv.seq_item_port.connect(sqr.seq_item_export);
    drv.vif = vif;
  end
endfunction

`endif

