//
// Do pio read/write using transactions.
// Not using the register model
//
`ifndef INCLUDED_blockA_xact_test_svh
`define INCLUDED_blockA_xact_test_svh

class blockA_xact_test extends blockA_base_test;
  `uvm_component_utils(blockA_xact_test)

  function new(string name="blockA_xact_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    pio_xact_write_sequence write_seq;
    pio_xact_read_sequence read_seq;
    
    write_seq = pio_xact_write_sequence::type_id::create(.name("pio_wr_seq"));
    read_seq = pio_xact_read_sequence::type_id::create(.name("pio_rd_seq"));
    
    phase.raise_objection(.obj(this));
    wait_for_reset();

    `uvm_info(get_full_name(), "Starting blockA_xact_test after reset", UVM_LOW);
    write_seq.addr = 32'ha000_1000;
    write_seq.data_w = 32'hdeadbeef;
    write_seq.start(.sequencer(env.pio_agent_inst.sqr));

    read_seq.addr = 32'ha000_1000;
    read_seq.start(.sequencer(env.pio_agent_inst.sqr));
    if(read_seq.data_r != 'hdeadbeef) begin
      `uvm_error(get_full_name(), 
        $psprintf("Read data mismatch. Got=0x%0x, Exp=0x%0x", read_seq.data_r, 32'hdeadbeef))
    end
                   
    write_seq.data_w = 32'hf00dcafe;
    write_seq.start(.sequencer(env.pio_agent_inst.sqr));
    read_seq.start(.sequencer(env.pio_agent_inst.sqr));
    if(read_seq.data_r != 'hf00dcafe) begin
      `uvm_error(get_full_name(), 
        $psprintf("Read data mismatch. Got=0x%0x, Exp=0x%0x", read_seq.data_r, 32'hf00dcafe))
    end
    #100ns;
    phase.drop_objection(.obj(this));

  endtask
endclass
`endif
