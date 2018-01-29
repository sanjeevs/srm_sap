//
// Handle to select the pio adapter.
//
`ifndef INCLUDED_pio_bus_handle_svh
`define INCLUDED_pio_bus_handle_svh

//
// Select the pio adapter.
//
class pio_search_frontdoor extends srm_search_adapter;
  `uvm_object_utils(pio_search_frontdoor)

  function new(string name="pio_search_frontdoor");
    super.new(name);
  endfunction

  virtual function bit is_correct_adapter(srm_bus_adapter adapter);
    if(adapter.get_name() == "pio_bus_adapter") begin
      return 1;
    end else begin
      return 0;
    end
  endfunction
endclass

class pio_bus_handle extends srm_base_handle;
  pio_search_frontdoor search_frontdoor;
  `uvm_object_utils(pio_bus_handle)

  function new(string name="pio_bus_handle");
    super.new(name);
    search_frontdoor = pio_search_frontdoor::type_id::create("pio_search_frontdoor");
    initialize(.search_adapter(search_frontdoor), .addr_map_name("default"));
  endfunction


endclass

`endif
