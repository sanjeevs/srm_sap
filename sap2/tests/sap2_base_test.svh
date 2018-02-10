//
// Base test class for sap2 testbench.
//
`ifndef INCLUDED_sap2_base_test
`define INCLUDED_sap2_base_test

class sap2_base_test extends uvm_test;
  `uvm_component_utils(sap2_base_test)

  sap2_env_config env_cfg;
  sap2_env env;
  Sap2 regmodel;
  host_bus_handle host_handle;
  pio_bus_handle pio_0_handle;
  pio_bus_handle pio_1_handle;

  blockA_backdoor_adapter backdoor_adapter;
  blockA_backdoor_handle backdoor_handle;

  virtual clkgen_if clkgen_if;

  function new(string name="sap2_base_test", uvm_component parent=null);
    super.new(name, parent);
    regmodel = new(.name("sap2"), .parent(null));
  endfunction

  virtual task wait_for_reset();
    repeat(10) @(clkgen_if.clk);
  endtask

  function void build_phase(uvm_phase phase);
    `uvm_info(get_full_name(), "Building test uvm_base_test", UVM_NONE)

    if(!uvm_config_db#(virtual clkgen_if)::get(null, "uvm_test_top", "clkgen_if",
      clkgen_if)) begin
      `uvm_fatal(get_full_name(), "Cannot get() interface clkgen_if from uvm_config_db")
    end

    env_cfg = sap2_env_config::type_id::create("sap2_env_config", this);
    uvm_config_db #(sap2_env_config)::set(this, "*", "sap2_env_config", env_cfg);

    env = sap2_env::type_id::create("sap2_env", this);
    host_handle = host_bus_handle::type_id::create("host_bus_handle");
    pio_0_handle = pio_bus_handle::type_id::create("pio_0_handle");
    pio_1_handle = pio_bus_handle::type_id::create("pio_1_handle");

    backdoor_adapter = blockA_backdoor_adapter::type_id::create("blockA_backdoor_adapter", this);
    backdoor_adapter.prefix = "tb.dut.sap1_0.blockA"; // Default behavior
    backdoor_handle = blockA_backdoor_handle::type_id::create("blockA_backdoor_handle", this);

  endfunction
  
  function void connect_phase(uvm_phase phase);
    regmodel.add_adapter(env.host_agent_inst.adapter);
    regmodel.sap1_0.blockA.r1_reg_inst.add_adapter(backdoor_adapter);
    regmodel.sap1_1.blockA.r1_reg_inst.add_adapter(backdoor_adapter);
    regmodel.sap1_0.blockA.add_adapter(env.pio_agent_0_inst.adapter);
    regmodel.sap1_1.blockA.add_adapter(env.pio_agent_1_inst.adapter);
  endfunction

  function int get_num_errors();
    uvm_report_server server = get_report_server();
    return server.get_severity_count(UVM_ERROR);
  endfunction

  function void report_phase(uvm_phase phase);
    $display("\n");
    $display("====================================================");
    if(get_num_errors() == 0) begin
      $display("\tTEST PASSED.");
    end else begin
      $display("\tTEST FAILED. ErrCnt=%0d", get_num_errors());
    end
    $display("====================================================");
    $display("\n");
  endfunction


endclass
`endif
