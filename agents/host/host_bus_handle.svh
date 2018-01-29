//
// Handle to select the host adapter.
//
`ifndef INCLUDED_host_bus_handle_svh
`define INCLUDED_host_bus_handle_svh

//
// Select the host adapter.
//
class host_search_frontdoor extends srm_search_adapter;
  `uvm_object_utils(host_search_frontdoor)

  function new(string name="host_search_frontdoor");
    super.new(name);
  endfunction

  virtual function bit is_correct_adapter(srm_bus_adapter adapter);
    if(adapter.get_name() == "host_bus_adapter") begin
      return 1;
    end else begin
      return 0;
    end
  endfunction
endclass

class host_bus_handle extends srm_base_handle;
  host_search_frontdoor search_frontdoor;
  `uvm_object_utils(host_bus_handle)

  function new(string name="host_bus_handle");
    super.new(name);
    search_frontdoor = host_search_frontdoor::type_id::create("host_search_frontdoor");
    initialize(.search_adapter(search_frontdoor), .addr_map_name("default"));
  endfunction


endclass

`endif
