//
// Do pio read/write using transactions.
// Not using the register model
//
`ifndef INCLUDED_sap2_srm_test_svh
`define INCLUDED_sap2_srm_test_svh

class sap2_srm_test extends sap2_base_test;
  `uvm_component_utils(sap2_srm_test)

  function new(string name="sap2_srm_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    blockA_srm_reg_sequence reg_seq;

    reg_seq = blockA_srm_reg_sequence::type_id::create("blockA_srm_reg_sequence");
    phase.raise_objection(.obj(this));
    wait_for_reset();

    reg_seq.initialize(.regmodel(regmodel.sap1_0.blockA), .handle(host_handle));
    reg_seq.start(null);

    reg_seq.initialize(.regmodel(regmodel.sap1_1.blockA), .handle(host_handle));
    reg_seq.start(null);
    // `uvm_info(get_full_name(), "Running backdoor adapter", UVM_NONE);
    //reg_seq.handle = backdoor_handle;
    //reg_seq.start(null);
 
    // `uvm_info(get_full_name(), "Running pio adapter", UVM_NONE);
    //reg_seq.handle = pio_handle;
    //reg_seq.start(null);

    repeat(10) @(posedge clkgen_if.clk);
    phase.drop_objection(.obj(this));

  endtask

endclass
`endif
