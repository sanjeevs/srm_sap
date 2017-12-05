//
// Host bus transaction
//

`ifndef INCLUDED_host_xact_svh
`define INCLUDED_host_xact_svh

class host_xact extends uvm_sequence_item;
  bit rw;
  bit [31:0] addr;
  bit [31:0] data_w;
  bit [31:0] data_r;

  `uvm_object_utils_begin(host_xact)
    `uvm_field_int(rw, UVM_DEFAULT)
    `uvm_field_int(addr, UVM_DEFAULT)
    `uvm_field_int(data_w, UVM_DEFAULT)
    `uvm_field_int(data_r, UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name="host_xact");
    super.new(name);
  endfunction

endclass

`endif
