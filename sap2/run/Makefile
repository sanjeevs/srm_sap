#
# Simple Makefile
#

VCS = vcs -sverilog -timescale=1ns/1ns +acc +vpi -debug_all\
      +define+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR \
      +incdir+$(UVM_HOME)/src $(UVM_HOME)/src/uvm.sv  \
      $(UVM_HOME)/src/dpi/uvm_dpi.cc -CFLAGS -DVCS

SIMV = simv -l test.log

DESIGN = $(SAP_HOME)/sap1/dut/clkgen_if.sv \
         $(SAP_HOME)/sap1/dut/host_if.sv \
         $(SAP_HOME)/sap1/dut/pio_if.sv  \
	     $(SAP_HOME)/sap1/dut/host.sv   \
	     $(SAP_HOME)/sap1/dut/blockX.sv \
	     $(SAP_HOME)/sap1/dut/sap1.sv   \
	     $(SAP_HOME)/sap2/dut/sap2.sv   

TB = $(SAP_HOME)/sap2/tb/tb.sv

TESTNAME = sap1_srm_test

comp_vcs:
	$(VCS) $(INCDIR) $(DESIGN) $(TB) 

run_vcs: comp_vcs
	$(SIMV) +UVM_TESTNAME=$(TESTNAME) 

clean:
	rm -rf csrc simv simv.daidir vc_hdrs.h DVEfiles *.log *.key *.vpd
