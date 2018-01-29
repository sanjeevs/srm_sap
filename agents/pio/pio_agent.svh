//
// Pio agent for driving xact on the pio bus.
//
// A generic uvm agent + pio_bus_adapter that converts the
// generic srm xact into a pio xact. This allows the agent to be reused unchanged
// in higher level hierarchy.
//
`ifndef INCLUDED_pio_agent 
`define INCLUDED_pio_agent
class pio_agent extends uvm_agent;
  
  `uvm_component_utils(pio_agent)

  virtual pio_if vif;

  // Component members
  uvm_analysis_port #(pio_xact) ap;
  pio_driver drv;
  pio_sequencer sqr;
  pio_agent_config cfg;
  pio_bus_adapter adapter;  // Adapter to convert srm xact to pio xact.

  // Standard UVM methods
  extern function new(string name="pio_agent", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

endclass

function pio_agent::new(string name="pio_agent", uvm_component parent = null);
  super.new(name, parent);
endfunction

function void pio_agent::build_phase(uvm_phase phase);
  `uvm_info(get_full_name(), "Starting to build pio_agent", UVM_NONE)
  if(!uvm_config_db#(pio_agent_config)::get(this, "", "pio_agent_config", cfg)) begin
    `uvm_fatal("CONFIG_LOAD", "Cannot get() pio_agent_config from config_db")
  end
  if(cfg.active == UVM_ACTIVE) begin
    drv = pio_driver::type_id::create("pio_driver", this);
    sqr = pio_sequencer::type_id::create("pio_sequencer", this);
    adapter = pio_bus_adapter::type_id::create("pio_bus_adapter", this);
  end
endfunction

function void pio_agent::connect_phase(uvm_phase phase);
  if(cfg.active == UVM_ACTIVE) begin
    `uvm_info(get_full_name(), "Connecting up pio_agent", UVM_NONE)
    drv.seq_item_port.connect(sqr.seq_item_export);
    drv.vif = vif;
  end
endfunction

`endif

