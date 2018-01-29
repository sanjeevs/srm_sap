// 
// Pio driver
// This driver uses force/release to drive the interface. This allows it 
// to be used at higher level testbenches where the RTL driver is also connected,
// but inactive.
//
`ifndef INCLUDED_pio_driver_svh
`define INCLUDED_pio_driver_svh

class pio_driver extends uvm_driver #(pio_xact);

  `uvm_component_utils(pio_driver)

  // Virtual interface
  virtual interface pio_if vif;
 
  // Standard uvm methods
  extern function new(string name = "pio_driver", uvm_component parent = null);
  extern task run_phase(uvm_phase phase);
endclass

function pio_driver::new(string name = "pio_driver", uvm_component parent = null);
  super.new(name, parent);
endfunction

task pio_driver::run_phase(uvm_phase phase);
  pio_xact xact;
  `uvm_info("RunPhase", "In run phase for reset driver", UVM_LOW)

  @(negedge vif.reset);
  `uvm_info(get_type_name(), "Reset De-asserted", UVM_LOW)
  repeat(2) @(posedge vif.clk);

  // Active Loop
  forever begin
    seq_item_port.try_next_item(xact);
    if(xact != null) begin
      @(posedge vif.clk);
      vif.cmd_vld = 1'b1;
      vif.rw = xact.rw;
      vif.addr = xact.addr;
      if(xact.rw == 'd1) begin
        vif.data_w = xact.data_w;
      end
      @(posedge vif.clk);
      vif.cmd_vld = 1'b0;
      vif.data_w = 32'h0;
      
      if(xact.rw == 'd0) begin
        wait(vif.rd_vld);
        xact.data_r = vif.data_r;
        @(posedge vif.clk);
      end

      seq_item_port.item_done();
    end
    else begin
      @(posedge vif.clk);
    end
  end
endtask


`endif

