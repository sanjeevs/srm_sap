`ifndef INCLUDED_blockA_backdoor_handle_svh
`define INCLUDED_blockA_backdoor_handle_svh
class blockA_backdoor_handle extends srm_base_handle;
  `uvm_object_utils(blockA_backdoor_handle)

  function new(string name="blockA_backdoor_handle");
    super.new(name);
    initialize(.addr_map_name("default"));
  endfunction

  virtual function bit is_correct_adapter(srm_bus_adapter adapter);
    if(adapter.get_name() == "blockA_backdoor_adapter") begin
      return 1;
    end else begin
      return 0;
    end
  endfunction

endclass

`endif
