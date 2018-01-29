//
// Generate basic read write sequences for pio bus.
//

`ifndef INCLUDED_pio_seq_lib_svh
`define INCLUDED_pio_seq_lib_svh

// Write sequence
class pio_xact_write_sequence extends uvm_sequence#(pio_xact);
  `uvm_object_utils(pio_xact_write_sequence)
  reg [31:0] addr;
  reg [31:0] data_w;

  function new(string name="pio_xact_write_sequence");
    super.new(name);
  endfunction

  task body();
    pio_xact pio_tx;
    `uvm_info(get_full_name(), 
      $psprintf("Writing addr=0x%0x, data_w=0x%0x", addr, data_w), UVM_LOW)
    pio_tx = pio_xact::type_id::create(.name("pio_tx"));
    start_item(pio_tx);
    pio_tx.addr = addr;
    pio_tx.rw = 1;
    pio_tx.data_w = data_w; 
    finish_item(pio_tx);
  endtask
endclass

// Read sequence.
class pio_xact_read_sequence extends uvm_sequence#(pio_xact);
  `uvm_object_utils(pio_xact_read_sequence)
  reg [31:0] addr;   // Input address.
  reg [31:0] data_r; // Return the read value.

  function new(string name="pio_xact_write_sequence");
    super.new(name);
  endfunction

  task body();
    pio_xact pio_tx;
    `uvm_info(get_full_name(), $psprintf("Reading addr=0x%0x", addr), UVM_LOW)
    pio_tx = pio_xact::type_id::create(.name("pio_tx"));
    start_item(pio_tx);
    pio_tx.addr = addr;
    pio_tx.rw = 0;
    finish_item(pio_tx);
    data_r = pio_tx.data_r;
  endtask
endclass

`endif
