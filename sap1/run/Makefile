#
# Simple Makefile
#

VCS = vcs -sverilog -timescale=1ns/1ns +acc +vpi -debug_all\
      +define+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR \
      +incdir+$(UVM_HOME)/src $(UVM_HOME)/src/uvm.sv  \
      +incdir+$(SRM_HOME)/src $(SRM_HOME)/src/srm.sv \
      +incdir+../tb +incdir+../agents/host +incdir+../env +incdir+../tests \
      +incdir+$(SAP_HOME)/regmodel \
      $(UVM_HOME)/src/dpi/uvm_dpi.cc -CFLAGS -DVCS

SIMV = simv -l test.log

DESIGN = $(SAP_HOME)/dut/clkgen_if.sv \
         $(SAP_HOME)/dut/host_if.sv \
         $(SAP_HOME)/dut/pio_if.sv  \
	     $(SAP_HOME)/dut/host.sv   \
	     $(SAP_HOME)/dut/blockX.sv \
	     $(SAP_HOME)/dut/sap1.sv

TB = $(SAP_HOME)/tb/tb.sv \
     $(SAP_HOME)/agents/host/host_agent_pkg.sv \
     $(SAP_HOME)/regmodel/sap1_srm_model_pkg.sv \
     $(SAP_HOME)/env/sap1_env_pkg.sv \
     $(SAP_HOME)/tests/sap1_test_pkg.sv

TESTNAME = sap1_srm_test

comp_vcs:
	$(VCS) $(INCDIR) $(DESIGN) $(TB) 

run_vcs: comp_vcs
	$(SIMV) +UVM_TESTNAME=$(TESTNAME) 

clean:
	rm -rf csrc simv simv.daidir vc_hdrs.h DVEfiles *.log *.key *.vpd
