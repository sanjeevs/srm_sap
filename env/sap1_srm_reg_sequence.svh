`ifndef INCLUDED_sap1_srm_reg_sequence_svh
`define INCLUDED_sap1_srm_reg_sequence_svh

class sap1_srm_reg_sequence extends uvm_sequence;
  `uvm_object_utils(sap1_srm_reg_sequence)

  Sap1 regmodel;
  srm_base_handle handle;
  reg[31:0] rd_data;

  function new(string name="");
    super.new(name);
  endfunction

  function void initialize(Sap1 regmodel, srm_base_handle handle);
    this.regmodel = regmodel; 
    this.handle = handle;
  endfunction

  virtual task body();
    `uvm_info(get_full_name(), "Starting sap1_srm_reg after reset", UVM_LOW);
    regmodel.blockX_node_inst.r1_reg_inst.write(handle, 'hdeadbeef);
    `uvm_info(get_full_name(), "Finished sap1_srm_reg write", UVM_LOW);

    `uvm_info(get_full_name(), "Starting sap1_srm_reg read", UVM_LOW);
    regmodel.blockX_node_inst.r1_reg_inst.read(handle, rd_data);
    `uvm_info(get_full_name(), "Finished sap1_srm_reg read", UVM_LOW);
    `uvm_info(get_full_name(), 
      $psprintf("Read-Write register ReadData=0x%0x", rd_data), UVM_LOW);
    
    regmodel.blockX_node_inst.r1_reg_inst.write(handle, 'hf00dcafe);
    regmodel.blockX_node_inst.r1_reg_inst.read(handle, rd_data);
    `uvm_info(get_full_name(), 
      $psprintf("Read-Write register ReadData=0x%0x", rd_data), UVM_LOW);
  endtask
endclass

`endif
