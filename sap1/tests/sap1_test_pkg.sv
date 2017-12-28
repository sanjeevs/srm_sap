//
// Package for the sap1 tests
//

package sap1_test_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import sap1_env_pkg::*;
  import host_agent_pkg::*;
  import sap1_srm_model_pkg::*;

  `include "sap1_base_test.svh"
  `include "sap1_xact_test.svh"
  `include "sap1_srm_test.svh"
endpackage
