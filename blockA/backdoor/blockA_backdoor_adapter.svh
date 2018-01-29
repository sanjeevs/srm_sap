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

  // FIXME: move this to a generic uvm_hdl_data_t in infra
  function bit[31:0] generic_xact_to_bus32(ref srm_generic_xact_t generic_xact);
    reg [31:0] bus_data = 'd0;
    // [31:0] = {byte3, byte2, byte1, byte0}
    for(int i = generic_xact.data.size()-1; i >= 0; i--) begin
      bus_data <<= 8;
      bus_data[7:0] = generic_xact.data[i];
    end
    return bus_data;
  endfunction

  virtual task execute(ref srm_generic_xact_t generic_xact, int seq_priority);
    reg[31:0] temp;
    int status;
    string path;

    // FIXME: Need to decode either r1 or t1 depending on the offset.
    path = {prefix, ".r1"}; 
    if(generic_xact.kind == SRM_WRITE) begin
      temp = generic_xact_to_bus32(generic_xact);
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
      // {byte3, byte2, byte1, byte0} = [31:0]
      foreach(generic_xact.data[i]) begin
        generic_xact.data[i] = temp[7:0];
        temp >>= 8;
      end
    end

  endtask

endclass

`endif
