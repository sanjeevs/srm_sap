`ifndef INCLUDED_blockA_srm_reg_sequence_svh
`define INCLUDED_blockA_srm_reg_sequence_svh

class blockA_srm_reg_sequence extends uvm_sequence;
  `uvm_object_utils(blockA_srm_reg_sequence)

  BlockA regmodel;
  srm_base_handle handle;
  BlockA::r1_struct_t rd_data;
  BlockA::r1_struct_t exp_data;

  function new(string name="");
    super.new(name);
  endfunction

  function void initialize(BlockA regmodel, srm_base_handle handle);
    this.regmodel = regmodel; 
    this.handle = handle;
  endfunction

  virtual task body();
    blockA_constr::r1_constr c1 = blockA_constr::r1_constr::type_id::create("r1_constr");
    assert(c1.randomize());

    exp_data = c1.get_data();
    `uvm_info(get_full_name(), 
      $psprintf("Test Wr-Rd 0x%0x to r1", exp_data.field0), UVM_LOW);
    regmodel.r1.write(handle, exp_data);

    `uvm_info(get_full_name(), "Starting blockA_srm_reg read", UVM_LOW);
    regmodel.r1.read(handle, rd_data);
    if(rd_data != exp_data) begin
      `uvm_error(get_full_name(), 
        $psprintf("Read Mismatch. Reg r1 ReadData=0x%0x, Exp=0x%0x", rd_data.field0, exp_data.field0))
    end
    else begin
      `uvm_info(get_full_name(), 
        $psprintf("Reg Read Match. Reg r1 ReadData=0x%0x, Exp=0x%0x", rd_data, exp_data),
        UVM_LOW);
    end
  endtask
endclass

`endif
