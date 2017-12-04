//====================================================================
//     $Id: $
//
// Copyright (c) 2014, Juniper Networks, Inc.
// All rights reserved.
//
// Sanjeev Singh, sanjeevs@juniper.net
//
// host_agent_config.svh - Configuration paramters
//
// Description: Configuration file for the agent.
//
//====================================================================

`ifndef INCLUDED_host_agent_config
`define INCLUDED_host_agent_config

class host_agent_config extends uvm_object;
  `uvm_object_utils(host_agent_config)

  virtual host_if vif;
  uvm_active_passive_enum active = UVM_ACTIVE;
  bit send_x = 1;  // Driver sends x or random data
  
  // Standard UVM stuff.
  function new(string name = "host_agent_config");
    super.new(name);
  endfunction

endclass

`endif
