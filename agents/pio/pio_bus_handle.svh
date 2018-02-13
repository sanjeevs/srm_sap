//
// Handle to select the pio adapter.
//
`ifndef INCLUDED_pio_bus_handle_svh
`define INCLUDED_pio_bus_handle_svh

class pio_bus_handle extends srm_base_handle;
  `uvm_object_utils(pio_bus_handle)

  function new(string name="pio_bus_handle");
    super.new(name);
    initialize(.addr_map_name("default"));
  endfunction


  virtual function bit is_correct_adapter(srm_bus_adapter adapter);
    if(adapter.get_name() == "pio_bus_adapter") begin
      return 1;
    end else begin
      return 0;
    end
  endfunction
endclass

`endif
