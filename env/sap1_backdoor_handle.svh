`ifndef INCLUDED_sap1_backdoor_handle_svh
`define INCLUDED_sap1_backdoor_handle_svh
//
// Prefer using backdoor (if available). else switch to
// frontdoor.
// FIXME: This is currently hardwired to backdoor only.
class sap1_search_backdoor extends srm_search_adapter;
  `uvm_object_utils(sap1_search_backdoor)

  function new(string name="sap1_search_backdoor");
    super.new(name);
  endfunction

  virtual function bit is_correct_adapter(srm_bus_adapter adapter);
    if(adapter.get_name() == "sap1_backdoor_adapter") begin
      return 1;
    end else begin
      return 0;
    end
  endfunction
endclass

class sap1_backdoor_handle extends srm_base_handle;
  sap1_search_backdoor search_backdoor;
  `uvm_object_utils(sap1_backdoor_handle)

  function new(string name="sap1_backdoor_handle");
    super.new(name);
    search_backdoor = sap1_search_backdoor::type_id::create("sap1_search_backdoor");
    initialize(.search_adapter(search_backdoor), .addr_map_name("default"));
  endfunction


endclass

`endif
