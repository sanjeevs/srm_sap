#
# Simple Makefile to run blockA testbench.
#

VCS = vcs -sverilog -timescale=1ns/1ns +acc +vpi -debug_all\
      +define+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR \
      +incdir+$(UVM_HOME)/src $(UVM_HOME)/src/uvm.sv  \
      +incdir+$(SRM_HOME)/src $(SRM_HOME)/src/srm.sv \
      +incdir+$(SAP_HOME)/blockA/tb +incdir+$(SAP_HOME)/agents/pio \
      +incdir+$(SAP_HOME)/blockA/env +incdir+$(SAP_HOME)/blockA/tests \
      +incdir+$(SAP_HOME)/blockA/regmodel \
      +incdir+$(SAP_HOME)/blockA/sequences \
      +incdir+$(SAP_HOME)/blockA/backdoor \
      $(UVM_HOME)/src/dpi/uvm_dpi.cc -CFLAGS -DVCS

SIMV = simv -l test.log

DESIGN = $(SAP_HOME)/agents/pio/pio_if.sv  \
	     $(SAP_HOME)/blockA/dut/blockA.sv

TB = $(SAP_HOME)/blockA/tb/clkgen_if.sv \
     $(SAP_HOME)/blockA/tb/tb.sv \
     $(SAP_HOME)/agents/pio/pio_agent_pkg.sv \
     $(SAP_HOME)/blockA/regmodel/blockA_srm_model_pkg.sv \
     $(SAP_HOME)/blockA/sequences/blockA_srm_reg_sequences_pkg.sv \
     $(SAP_HOME)/blockA/backdoor/blockA_backdoor_pkg.sv \
     $(SAP_HOME)/blockA/env/blockA_env_pkg.sv \
     $(SAP_HOME)/blockA/tests/blockA_test_pkg.sv

TESTNAME = blockA_reg_test

comp_vcs:
	$(VCS) $(INCDIR) $(DESIGN) $(TB) 

run_vcs: comp_vcs
	$(SIMV) +UVM_TESTNAME=$(TESTNAME) 

clean:
	rm -rf csrc simv simv.daidir vc_hdrs.h DVEfiles *.log *.key *.vpd
