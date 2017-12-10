//
// Do pio read/write using transactions.
// Not using the register model
//
`ifndef INCLUDED_sap1_xact_test_svh
`define INCLUDED_sap1_xact_test_svh

class sap1_xact_test extends sap1_base_test;
  `uvm_component_utils(sap1_xact_test)

  function new(string name="sap1_xact_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    host_xact_write_sequence write_seq;
    host_xact_read_sequence read_seq;
    
    write_seq = host_xact_write_sequence::type_id::create(.name("host_wr_seq"));
    read_seq = host_xact_read_sequence::type_id::create(.name("host_rd_seq"));
    
    phase.raise_objection(.obj(this));
    #100ns; 
    `uvm_info(get_full_name(), "Starting sap1_xact_test after reset", UVM_LOW);
    write_seq.addr = 32'ha000_1000;
    write_seq.data_w = 32'hdeadbeef;
    write_seq.start(.sequencer(env.host_agent_inst.sqr));

    @(posedge clkgen_if.clk);
    read_seq.addr = 32'ha000_1000;
    read_seq.start(.sequencer(env.host_agent_inst.sqr));
    if(read_seq.data_r != 'hdeadbeef) begin
      `uvm_error(get_full_name(), 
        $psprintf("Read data mismatch. Got=0x%0x, Exp=0x%0x", read_seq.data_r, 32'hdeadbeef))
    end
                   
    #100ns;
    phase.drop_objection(.obj(this));

  endtask
endclass
`endif
