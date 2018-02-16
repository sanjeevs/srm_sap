//
// Adapter to convert the accesses to backdoor access.
//
`ifndef INCLUDED_blockA_backdoor_adapter_svh
`define INCLUDED_blockA_backdoor_adapter_svh

class blockA_backdoor_adapter extends srm_bus_adapter;
  string prefix;
  `uvm_object_utils(blockA_backdoor_adapter)
  
  // Name is critical. the handle will use this to select the adapter.
  function new(string name="blockA_backdoor_adapter");
    super.new(name);
  endfunction

  virtual task execute(ref srm_generic_xact_t generic_xact, int seq_priority);
    uvm_hdl_data_t temp;
    int status;
    string path;
    logic[15:0] addr;
    string idx;

    addr = global_2_local_addr(generic_xact.addr);
    if(addr[12]) begin
      // Register
      path = {prefix, ".r1"}; 
    end else begin
      // Table
      idx.itoa(addr/32);
      path = {prefix, ".t1", "[", idx, "]"}; 
    end

    if(generic_xact.kind == SRM_WRITE) begin
      temp = generic_xact_to_hdl_data(generic_xact);
      status = uvm_hdl_deposit(path, temp);
      if(status == 0) begin
        `uvm_fatal("TbConfigurationError", 
          $psprintf("Hdl backdoor write failed to path '%s'", path));
      end
    end else begin
      temp = 'h0;
      status = uvm_hdl_read(path, temp);
      if(status == 0) begin
        `uvm_fatal("TbConfigurationError", 
          $psprintf("Hdl backdoor read failed to path '%s'", path));
      end
      hdl_data_to_generic_xact(generic_xact, temp);
    end

  endtask

  virtual function logic[15:0] global_2_local_addr(srm_addr_t global_addr);
    return global_addr[15:0];
  endfunction

endclass

`endif
