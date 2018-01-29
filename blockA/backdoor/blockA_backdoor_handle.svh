`ifndef INCLUDED_blockA_backdoor_handle_svh
`define INCLUDED_blockA_backdoor_handle_svh
//
// Select blockA backdoor adapter.

class blockA_search_backdoor extends srm_search_adapter;
  `uvm_object_utils(blockA_search_backdoor)

  function new(string name="blockA_search_backdoor");
    super.new(name);
  endfunction

  virtual function bit is_correct_adapter(srm_bus_adapter adapter);
    if(adapter.get_name() == "blockA_backdoor_adapter") begin
      return 1;
    end else begin
      return 0;
    end
  endfunction
endclass

class blockA_backdoor_handle extends srm_base_handle;
  blockA_search_backdoor search_backdoor;
  `uvm_object_utils(blockA_backdoor_handle)

  function new(string name="blockA_backdoor_handle");
    super.new(name);
    search_backdoor = blockA_search_backdoor::type_id::create("blockA_search_backdoor");
    initialize(.search_adapter(search_backdoor), .addr_map_name("default"));
  endfunction


endclass

`endif
