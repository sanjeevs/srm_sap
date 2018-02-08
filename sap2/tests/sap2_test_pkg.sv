//
// Package for the sap2 tests
// External dependency on the blockA register sequences.
//
package sap2_test_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import sap2_env_pkg::*;
  import host_agent_pkg::*;
  import pio_agent_pkg::*;
  import sap2_srm_model_pkg::*;
  import blockA_backdoor_pkg::*;  
  import blockA_srm_reg_sequences_pkg::*;

  `include "sap2_base_test.svh"
  `include "sap2_srm_test.svh"
endpackage
