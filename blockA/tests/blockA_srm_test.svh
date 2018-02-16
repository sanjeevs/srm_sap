//
// Pio test for blockA testbench.
//
`ifndef INCLUDED_blockA_srm_test
`define INCLUDED_blockA_srm_test

class blockA_srm_test extends blockA_base_test;
  `uvm_component_utils(blockA_srm_test)
  
  function new(string name="blockA_srm_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction
 

  task run_phase(uvm_phase phase);
    blockA_srm_reg_sequence reg_seq;
    blockA_srm_table_sequence table_seq;

    reg_seq = blockA_srm_reg_sequence::type_id::create("blockA_srm_reg_sequence");
    table_seq = blockA_srm_table_sequence::type_id::create("blockA_srm_table_sequence");
    phase.raise_objection(.obj(this));
    wait_for_reset();
    
    reg_seq.initialize(.regmodel(regmodel), .handle(pio_handle));
    reg_seq.start(null);
  
    table_seq.initialize(.regmodel(regmodel), .handle(pio_handle));
    table_seq.start(null);

    `uvm_info(get_full_name(), "Running backdoortraffic on r1", UVM_NONE);
    reg_seq.handle = backdoor_handle;
    reg_seq.start(null);

    `uvm_info(get_full_name(), "Running backdoortraffic on t1", UVM_NONE);
    table_seq.handle = backdoor_handle;
    table_seq.start(null);

    phase.drop_objection(.obj(this));

  endtask

endclass
`endif
