//
// Handle to select the host adapter.
//
`ifndef INCLUDED_host_bus_handle_svh
`define INCLUDED_host_bus_handle_svh

class host_bus_handle extends srm_base_handle;
  `uvm_object_utils(host_bus_handle)

  function new(string name="host_bus_handle");
    super.new(name);
    initialize(.addr_map_name("default"));
  endfunction

  virtual function bit is_correct_adapter(srm_bus_adapter adapter);
    if(adapter.get_name() == "host_bus_adapter") begin
      return 1;
    end else begin
      return 0;
    end
  endfunction
endclass

`endif
