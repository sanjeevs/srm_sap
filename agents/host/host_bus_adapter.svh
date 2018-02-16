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
  
  virtual task execute(ref srm_generic_xact_t generic_xact, int seq_priority);
    host_xact_write_sequence write_seq;
    host_xact_read_sequence read_seq;
    uvm_hdl_data_t temp;
    if(generic_xact.kind == SRM_WRITE) begin
      write_seq = host_xact_write_sequence::type_id::create(.name("host_wr_seq"));
      write_seq.addr = global_2_local_addr(generic_xact.addr);
      write_seq.data_w = generic_xact_to_hdl_data(generic_xact);
      write_seq.start(.sequencer(host_sqr));
    end else begin
      read_seq = host_xact_read_sequence::type_id::create(.name("host_rd_seq"));
      read_seq.addr = global_2_local_addr(generic_xact.addr);
      read_seq.start(.sequencer(host_sqr));
      temp = read_seq.data_r;
      hdl_data_to_generic_xact(generic_xact, temp);
    end

  endtask

  virtual function logic[15:0] global_2_local_addr(srm_addr_t global_addr);
    return global_addr[31:0];
  endfunction

endclass

`endif
