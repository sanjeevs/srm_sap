`ifndef INCLUDED_sap1_base_test
`define INCLUDED_sap1_base_test

class sap1_base_test extends uvm_test;
  `uvm_component_utils(sap1_base_test)

  sap1_env env;
  Sap1 regmodel;
  sap1_frontdoor_handle frontdoor_handle;

  virtual clkgen_if clkgen_if;

  function new(string name="sap1_base_test", uvm_component parent=null);
    super.new(name, parent);
    regmodel = new(.name("sap1"), .parent(null));
  endfunction

  function void build_phase(uvm_phase phase);
    `uvm_info(get_full_name(), "Building test uvm_base_test", UVM_NONE)

    if(!uvm_config_db#(virtual clkgen_if)::get(null, "uvm_test_top", "clkgen_if",
      clkgen_if)) begin
      `uvm_fatal(get_full_name(), "Cannot get() interface clkgen_if from uvm_config_db")
    end

    env = sap1_env::type_id::create("sap1_env", this);
    frontdoor_handle = sap1_frontdoor_handle::type_id::create("sap1_frontdoor_handle");

  endfunction
endclass
`endif
