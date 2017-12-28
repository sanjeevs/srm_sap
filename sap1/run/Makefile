#
# Simple Makefile
#

VCS = vcs -sverilog -timescale=1ns/1ns +acc +vpi -debug_all\
      +define+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR \
      +incdir+$(UVM_HOME)/src $(UVM_HOME)/src/uvm.sv  \
      +incdir+$(SRM_HOME)/src $(SRM_HOME)/src/srm.sv \
      +incdir+$(SAP_HOME)/sap1/tb +incdir+$(SAP_HOME)/sap1/agents/host \
	  +incdir+$(SAP_HOME)/sap1/env +incdir+$(SAP_HOME)/sap1/tests \
      +incdir+$(SAP_HOME)/sap1/regmodel \
      $(UVM_HOME)/src/dpi/uvm_dpi.cc -CFLAGS -DVCS

SIMV = simv -l test.log

DESIGN = $(SAP_HOME)/sap1/dut/clkgen_if.sv \
         $(SAP_HOME)/sap1/dut/host_if.sv \
         $(SAP_HOME)/sap1/dut/pio_if.sv  \
	     $(SAP_HOME)/sap1/dut/host.sv   \
	     $(SAP_HOME)/sap1/dut/blockX.sv \
	     $(SAP_HOME)/sap1/dut/sap1.sv

TB = $(SAP_HOME)/sap1/tb/tb.sv \
     $(SAP_HOME)/sap1/agents/host/host_agent_pkg.sv \
     $(SAP_HOME)/sap1/regmodel/sap1_srm_model_pkg.sv \
     $(SAP_HOME)/sap1/env/sap1_env_pkg.sv \
     $(SAP_HOME)/sap1/tests/sap1_test_pkg.sv

TESTNAME = sap1_srm_test

comp_vcs:
	$(VCS) $(INCDIR) $(DESIGN) $(TB) 

run_vcs: comp_vcs
	$(SIMV) +UVM_TESTNAME=$(TESTNAME) 

clean:
	rm -rf csrc simv simv.daidir vc_hdrs.h DVEfiles *.log *.key *.vpd
