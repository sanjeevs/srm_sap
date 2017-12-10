//====================================================================
//     $Id:  $
// $Author: sanjeevs $
//
// Copyright (c) 2014, Juniper Networks, Inc.
// All rights reserved.
//
// Sanjeev Singh, sanjeevs@juniper.net
//
// host_driver.svh - drives  host_if interface pins.
//
// Description: 
// Implements generic
//====================================================================

`ifndef INCLUDED_host_driver_svh
`define INCLUDED_host_driver_svh

class host_driver extends uvm_driver #(host_xact);

  `uvm_component_utils(host_driver)

  // Virtual interface
  virtual interface host_if vif;
 
  // Standard uvm methods
  extern function new(string name = "host_driver", uvm_component parent = null);
  extern task run_phase(uvm_phase phase);
  extern task synch_send_idle();       // Helper
endclass

function host_driver::new(string name = "host_driver", uvm_component parent = null);
  super.new(name, parent);
endfunction

task host_driver::run_phase(uvm_phase phase);
  host_xact req;
  `uvm_info("RunPhase", "In run phase for reset driver", UVM_LOW)
  vif.cmd_vld = 1'b0;

  @(negedge vif.reset);
  `uvm_info(get_type_name(), "Reset De-asserted", UVM_LOW)
  repeat(2) @(posedge vif.clk);

  // Active Loop
  forever begin
    seq_item_port.try_next_item(req);
    if(req != null) begin
      vif.cmd_vld = 1'b1;
      vif.addr = req.addr;
      vif.rw = req.rw;
      if(req.rw) begin
        // Write: Drive the write data with the cmd.
        vif.data_w = req.data_w;
        @(posedge vif.clk);
      end else begin
        // Read: Drop the cmd and wait for rd data.
        @(posedge vif.clk);
        vif.cmd_vld = 1'b0;
        wait(vif.rd_vld);
        @(posedge vif.clk);
        req.data_r = vif.data_r; 
      end
      seq_item_port.item_done();
    end
    else begin
      // No command: Just drive idle.
      vif.cmd_vld = 1'b0;
      vif.addr = 'h0;
      vif.data_w = 'h0;
      @(posedge vif.clk);
    end
  end
endtask

task host_driver::synch_send_idle();
endtask


`endif

