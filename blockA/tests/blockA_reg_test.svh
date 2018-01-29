//
// Pio test for blockA testbench.
//
`ifndef INCLUDED_blockA_reg_test
`define INCLUDED_blockA_reg_test

class blockA_reg_test extends blockA_base_test;
  `uvm_component_utils(blockA_reg_test)
  
  function new(string name="blockA_reg_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction
 

  task run_phase(uvm_phase phase);
    blockA_srm_reg_sequence reg_seq;

    reg_seq = blockA_srm_reg_sequence::type_id::create("blockA_srm_reg_sequence");
    phase.raise_objection(.obj(this));
    wait_for_reset();
    
    reg_seq.initialize(.regmodel(regmodel), .handle(pio_handle));
    reg_seq.start(null);
  
    `uvm_info(get_full_name(), "Running background traffic", UVM_NONE);
    reg_seq.handle = backdoor_handle;
    reg_seq.start(null);

    phase.drop_objection(.obj(this));

  endtask

endclass
`endif
