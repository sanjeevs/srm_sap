//====================================================================
//     $Id:  $
//
// Copyright (c) 2014, Juniper Networks, Inc.
// All rights reserved.
//
// Sanjeev Singh, sanjeevs@juniper.net
//
// host_sequencer.svh - host_sequencer
//
// Description: Send valid xact to driver when the credit is available.
//
//====================================================================

`ifndef INCLUDED_host_sequencer
`define INCLUDED_host_sequencer

class host_sequencer extends uvm_sequencer#(host_xact);
  `uvm_component_utils(host_sequencer)

  function new(string name="host_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

endclass

`endif

