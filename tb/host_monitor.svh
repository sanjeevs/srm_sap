//====================================================================
//     $Id: //depot/icm/proj/secaes/trunk/verif/verif/secaes/agents/secaes_din/secaes_din_monitor.svh#10 $
// $Author: jscott $
//
// Copyright (c) 2014, Juniper Networks, Inc.
// All rights reserved.
//
// Sanjeev Singh, sanjeevs@juniper.net
//
// host_monitor.svh - monitor the host_if interface. 
//
// Description: 
// Implements the sender side for  protocol.
//====================================================================
`ifndef INCLUDED_host_monitor_svh
`define INCLUDED_host_monitor_svh

class host_monitor extends uvm_monitor;

  `uvm_component_utils(host_monitor)


  virtual host_if vif;
  uvm_analysis_port #(host_if_packet) ap;

  // Standard UVM methods
  extern function new(string name = "host_monitor", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern function void report_phase(uvm_phase phase);

endclass

function host_monitor::new(string name = "host_monitor", uvm_component parent = null);
    super.new(name, parent);
endfunction

function void host_monitor::build_phase(uvm_phase phase);
  ap = new("ap", this);
endfunction

task host_monitor::run_phase(uvm_phase phase);
  @(negedge vif.reset);
endtask

function void host_monitor::report_phase(uvm_phase phase);
endfunction

`endif
