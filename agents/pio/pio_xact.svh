//
// Transaction on the PIO bus.
// The pio bus is a generic 32b sw bus.
//
`ifndef INCLUDED_pio_xact_svh
`define INCLUDED_pio_xact_svh

class pio_xact extends uvm_sequence_item;
  bit rw;            // 0- read, 1 -write
  bit [31:0] addr;   // 32b address
  bit [31:0] data_w; // Data to be written.
  bit [31:0] data_r; // Read data to be sampled.

  `uvm_object_utils_begin(pio_xact)
    `uvm_field_int(rw, UVM_DEFAULT)
    `uvm_field_int(addr, UVM_DEFAULT)
    `uvm_field_int(data_w, UVM_DEFAULT)
    `uvm_field_int(data_r, UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name="pio_xact");
    super.new(name);
  endfunction

endclass

`endif
