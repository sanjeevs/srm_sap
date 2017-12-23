`ifndef INCLUDED_srm_frontdoor_handle_svh
`define INCLUDED_srm_frontdoor_handle_svh

class srm_search_frontdoor extends srm_search_adapter;
  `uvm_object_utils(srm_search_frontdoor)

  function new(string name="srm_frontdoor_handle");
    super.new(name);
  endfunction

  virtual function bit is_correct_adapter(srm_bus_adapter adapter);
    if(adapter.get_name() == "frontdoor") begin
      return 1;
    end else begin
      return 0;
    end
  endfunction
endclass

class srm_frontdoor_handle extends srm_base_handle;
  srm_search_frontdoor search_frontdoor;
  `uvm_object_utils(srm_frontdoor_handle)

  function new(string name="srm_frontdoor_handle");
    super.new(name);
    search_frontdoor = srm_search_frontdoor::type_id::create("srm_search_frontdoor");
    initialize(.search_adapter(search_frontdoor), .addr_map_name("default"));
  endfunction


endclass

`endif
