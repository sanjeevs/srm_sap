`ifndef INCLUDED_blockA_srm_table_sequence_svh
`define INCLUDED_blockA_srm_table_sequence_svh

class blockA_srm_table_sequence extends uvm_sequence;
  `uvm_object_utils(blockA_srm_table_sequence)

  BlockA regmodel;
  srm_base_handle handle;
  BlockA::t1_struct_t rd_data;
  BlockA::t1_struct_t exp_data;

  function new(string name="");
    super.new(name);
  endfunction

  function void initialize(BlockA regmodel, srm_base_handle handle);
    this.regmodel = regmodel; 
    this.handle = handle;
  endfunction

  virtual task body();
    BlockA::t1_constr c1 = BlockA::t1_constr::type_id::create("t1_constr");
    assert(c1.randomize());

    exp_data = c1.get_data();
    `uvm_info(get_full_name(), 
      $psprintf("Test Wr-Rd 0x%0x to t1_table", exp_data), UVM_LOW);
    regmodel.t1_table_inst.entry_at(1023).write(handle, exp_data);

    `uvm_info(get_full_name(), "Starting blockA_srm_table read", UVM_LOW);
    regmodel.t1_table_inst.entry_at(1023).read(handle, rd_data);
    if(rd_data != exp_data) begin
      `uvm_error(get_full_name(), 
        $psprintf("Read Mismatch. block t1 ReadData=0x%0x, Exp=0x%0x", rd_data, exp_data))
    end
    else begin
      `uvm_info(get_full_name(), 
        $psprintf("Reg Read Match. block t1 ReadData=0x%0x, Exp=0x%0x", rd_data, exp_data),
        UVM_LOW);
    end
  endtask
endclass

`endif
