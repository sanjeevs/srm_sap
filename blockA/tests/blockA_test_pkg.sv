//
// Package for the blockA tests
//

package blockA_test_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import blockA_env_pkg::*;
  import pio_agent_pkg::*;
  import blockA_srm_model_pkg::*;
  import blockA_srm_reg_sequences_pkg::*;
  import blockA_backdoor_pkg::*;
  `include "blockA_base_test.svh"
  `include "blockA_xact_test.svh"
  `include "blockA_srm_test.svh"
endpackage
