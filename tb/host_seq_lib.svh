//
// List of all the test sequences
//
`ifndef INCLUDED_host_seq_lib_svh
`define INCLUDED_host_seq_lib_svh

class host_xact_write_sequence extends uvm_sequence#(host_xact);
  `uvm_object_utils(host_xact_write_sequence)
  reg [31:0] addr;
  reg [31:0] data_w;

  function new(string name="host_xact_write_sequence");
    super.new(name);
  endfunction

  task body();
    host_xact host_tx;
    `uvm_info(get_full_name(), 
      $psprintf("Writing addr=0x%0x, data_w=0x%0x", addr, data_w), UVM_LOW)
    host_tx = host_xact::type_id::create(.name("host_tx"));
    start_item(host_tx);
    host_tx.addr = addr;
    host_tx.rw = 1;
    host_tx.data_w = data_w; 
    finish_item(host_tx);
  endtask
endclass

class host_xact_read_sequence extends uvm_sequence#(host_xact);
  `uvm_object_utils(host_xact_read_sequence)
  reg [31:0] addr;
  reg [31:0] data_r;

  function new(string name="host_xact_write_sequence");
    super.new(name);
  endfunction

  task body();
    host_xact host_tx;
    `uvm_info(get_full_name(), $psprintf("Reading addr=0x%0x", addr), UVM_LOW)
    host_tx = host_xact::type_id::create(.name("host_tx"));
    start_item(host_tx);
    host_tx.addr = addr;
    host_tx.rw = 0;
    finish_item(host_tx);
    data_r = host_tx.data_r;
  endtask
endclass

`endif
