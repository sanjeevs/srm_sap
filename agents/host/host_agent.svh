//====================================================================
//     $Id: //depot/icm/proj/secaes/trunk/verif/verif/secaes/agents/secaes_din/secaes_din_agent.svh#9 $
// $Author: jscott $
//
// Copyright (c) 2014, Juniper Networks, Inc.
// All rights reserved.
//
// Sanjeev Singh, sanjeevs@juniper.net
//
// host_agent.svh - 
//
// Description: 
// Agent implements the generic//====================================================================

`ifndef INCLUDED_host_agent 
`define INCLUDED_host_agent
class host_agent extends uvm_agent;
  
  `uvm_component_utils(host_agent)

  virtual host_if vif;

  // Component members
  uvm_analysis_port #(host_xact) ap;
  host_driver drv;
  host_sequencer sqr;

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
  drv = host_driver::type_id::create("host_driver", this);
  sqr = host_sequencer::type_id::create("host_sequencer", this);
endfunction

function void host_agent::connect_phase(uvm_phase phase);
  `uvm_info(get_full_name(), "Connecting up host_agent", UVM_NONE)
  drv.seq_item_port.connect(sqr.seq_item_export);
  drv.vif = vif;
endfunction

`endif

