#
# Simple Makefile
#

VCS = vcs -sverilog -timescale=1ns/1ns +acc +vpi -debug_all\
      +define+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR \
	  +incdir+$(UVM_HOME)/src +incdir+../tb $(UVM_HOME)/src/uvm.sv \
	  $(UVM_HOME)/src/dpi/uvm_dpi.cc -CFLAGS -DVCS

SIMV = simv -l test.log

DESIGN = ../dut/clkgen_if.sv \
         ../dut/host_if.sv \
         ../dut/pio_if.sv  \
		 ../dut/host.sv   \
		 ../dut/blockX.sv \
		 ../dut/sap1.sv

TB = ../tb/tb.sv \
     ../tb/host_agent_pkg.sv \
	 ../tb/sap1_env_pkg.sv \
	 ../tb/sap1_test_pkg.sv

TESTNAME = sap1_xact_test

comp_vcs:
	$(VCS) $(INCDIR) $(DESIGN) $(TB) 

run_vcs: comp_vcs
	$(SIMV) +UVM_TESTNAME=$(TESTNAME) 

dbg_vcs: comp_vcs
	$(SIMV) +UVM_TESTNAME=$(TESTNAME)

clean:
	rm -rf csrc simv simv.daidir vc_hdrs.h DVEfiles *.log *.key *.vpd
