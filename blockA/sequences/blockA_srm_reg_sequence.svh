`ifndef INCLUDED_blockA_srm_reg_sequence_svh
`define INCLUDED_blockA_srm_reg_sequence_svh

class blockA_srm_reg_sequence extends uvm_sequence;
  `uvm_object_utils(blockA_srm_reg_sequence)

  BlockA regmodel;
  srm_base_handle handle;
  reg[31:0] rd_data;
  reg[31:0] exp_data;

  function new(string name="");
    super.new(name);
  endfunction

  function void initialize(BlockA regmodel, srm_base_handle handle);
    this.regmodel = regmodel; 
    this.handle = handle;
  endfunction

  virtual task body();
    `uvm_info(get_full_name(), "Test Wr-Rd 0xdeadbeef to r1_reg", UVM_LOW);
    exp_data = 32'hdeadbeef;
    regmodel.r1_reg_inst.write(handle, exp_data);

    `uvm_info(get_full_name(), "Starting blockA_srm_reg read", UVM_LOW);
    regmodel.r1_reg_inst.read(handle, rd_data);
    if(rd_data != exp_data) begin
      `uvm_error(get_full_name(), 
        $psprintf("Read Mismatch. Reg r1 ReadData=0x%0x, Exp=0x%0x", rd_data, exp_data))
    end
    else begin
      `uvm_info(get_full_name(), 
        $psprintf("Reg Read Match. Reg r1 ReadData=0x%0x, Exp=0x%0x", rd_data, exp_data),
        UVM_LOW);
    end
  endtask
endclass

`endif
