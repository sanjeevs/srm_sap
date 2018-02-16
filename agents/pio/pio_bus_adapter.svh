//
// FIXME: 1. Remove generic_xact to srm_generic_xact_t returning uvm_hdl_data_t
//        2. Add initialize to the sequence.
//
`ifndef INCLUDED_pio_bus_adapter_svh
`define INCLUDED_pio_bus_adapter_svh

class pio_bus_adapter extends srm_bus_adapter;
  pio_sequencer pio_sqr;

  `uvm_object_utils(pio_bus_adapter)
    
  function new(string name="pio_bus_adapter");
    super.new(name);
  endfunction

 
  virtual task execute(ref srm_generic_xact_t generic_xact, int seq_priority);
    pio_xact_write_sequence write_seq;
    pio_xact_read_sequence read_seq;
    uvm_hdl_data_t temp;
    if(generic_xact.kind == SRM_WRITE) begin
      write_seq = pio_xact_write_sequence::type_id::create(.name("pio_wr_seq"));
      write_seq.addr = global_2_local_addr(generic_xact.addr);
      write_seq.data_w = generic_xact_to_hdl_data(generic_xact);
      write_seq.start(.sequencer(pio_sqr));
    end else begin
      read_seq = pio_xact_read_sequence::type_id::create(.name("pio_rd_seq"));
      read_seq.addr = global_2_local_addr(generic_xact.addr);
      read_seq.start(.sequencer(pio_sqr));
      temp = read_seq.data_r;
      hdl_data_to_generic_xact(generic_xact, temp);
    end

  endtask

  virtual function logic[15:0] global_2_local_addr(srm_addr_t global_addr);
    return global_addr[15:0];
  endfunction

endclass

`endif
