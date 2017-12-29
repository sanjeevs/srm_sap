//
// Package for the sap1 env
//

package sap1_env_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import srm_pkg::*; 
  import sap1_srm_model_pkg::*;     // Required for sap1_srm_reg_sequence.
  import host_agent_pkg::*;
  `include "sap1_host_bus_adapter.svh"
  `include "sap1_backdoor_adapter.svh"
  `include "sap1_frontdoor_handle.svh"
  `include "sap1_backdoor_handle.svh"
  `include "sap1_srm_reg_sequence.svh"
  `include "sap1_env_config.svh"
  `include "sap1_env.svh"
endpackage
