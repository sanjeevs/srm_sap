//
// Adapter to convert the accesses to backdoor access.
//
`ifndef INCLUDED_sap1_backdoor_adapter_svh
`define INCLUDED_sap1_backdoor_adapter_svh

class sap1_backdoor_adapter extends srm_bus_adapter;
  string prefix;
  `uvm_object_utils(sap1_backdoor_adapter)
    
  function new(string name="sap1_backdoor_adapter");
    super.new(name);
  endfunction

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

    path = {prefix, ".blockA.r1"}; 
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
