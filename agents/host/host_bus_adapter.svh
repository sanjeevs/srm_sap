//
// Bus Adapter to execute transaction on the host agent.
//
`ifndef INCLUDED_host_bus_adapter_svh
`define INCLUDED_host_bus_adapter_svh

class host_bus_adapter extends srm_bus_adapter;
  host_sequencer host_sqr;

  `uvm_object_utils(host_bus_adapter)
    
  function new(string name="host_bus_adapter");
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
    host_xact_write_sequence write_seq;
    host_xact_read_sequence read_seq;
    reg[31:0] temp;
    if(generic_xact.kind == SRM_WRITE) begin
      write_seq = host_xact_write_sequence::type_id::create(.name("host_wr_seq"));
      write_seq.addr = generic_xact.addr;
      write_seq.data_w = generic_xact_to_bus32(generic_xact);
      write_seq.start(.sequencer(host_sqr));
    end else begin
      read_seq = host_xact_read_sequence::type_id::create(.name("host_rd_seq"));
      read_seq.addr = generic_xact.addr;
      read_seq.start(.sequencer(host_sqr));
      temp = read_seq.data_r;
      // {byte3, byte2, byte1, byte0} = [31:0]
      foreach(generic_xact.data[i]) begin
        generic_xact.data[i] = temp[7:0];
        temp >>= 8;
      end
    end

  endtask

endclass

`endif
