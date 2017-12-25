`ifndef INCLUDED_sap1_frontdoor_handle_svh
`define INCLUDED_sap1_frontdoor_handle_svh

class host_search_frontdoor extends srm_search_adapter;
  `uvm_object_utils(host_search_frontdoor)

  function new(string name="host_frontdoor_handle");
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

class sap1_frontdoor_handle extends srm_base_handle;
  host_search_frontdoor search_frontdoor;
  `uvm_object_utils(sap1_frontdoor_handle)

  function new(string name="sap1_frontdoor_handle");
    super.new(name);
    search_frontdoor = host_search_frontdoor::type_id::create("host_search_frontdoor");
    initialize(.search_adapter(search_frontdoor), .addr_map_name("default"));
  endfunction


endclass

`endif
