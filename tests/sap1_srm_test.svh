//
// Do pio read/write using transactions.
// Not using the register model
//
`ifndef INCLUDED_sap1_srm_test_svh
`define INCLUDED_sap1_srm_test_svh

class sap1_srm_test extends sap1_base_test;
  `uvm_component_utils(sap1_srm_test)

  function new(string name="sap1_srm_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    sap1_srm_reg_sequence reg_seq;
    phase.raise_objection(.obj(this));
    #100ns;    // Wait for reset to be over

    `uvm_info(get_full_name(), "Starting sap1_srm_test after reset", UVM_LOW);
    reg_seq = sap1_srm_reg_sequence::type_id::create("sap1_srm_reg_sequence");
    reg_seq.initialize(.regmodel(regmodel), .handle(frontdoor_handle));
    reg_seq.start(null);

    phase.drop_objection(.obj(this));

  endtask

  function void build_phase(uvm_phase phase);
    `uvm_info(get_full_name(), "Building test uvm_base_test", UVM_NONE)
    super.build_phase(phase);
  endfunction

  function void connect_phase(uvm_phase phase);
    regmodel.add_adapter(env.host_bus_adapter);
  endfunction

endclass
`endif
