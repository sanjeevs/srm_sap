#
# Simple Makefile
#

VCS = vcs -sverilog -timescale=1ns/1ns +acc +vpi \
      +define+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR \
	  +incdir+$(UVM_HOME)/src +incdir+../tb $(UVM_HOME)/src/uvm.sv \
	  $(UVM_HOME)/src/dpi/uvm_dpi.cc -CFLAGS -DVCS


DESIGN = ../dut/host_if.sv \
         ../dut/pio_if.sv  \
		 ../dut/host.sv   \
		 ../dut/blockX.sv \
		 ../dut/sap1.sv

TB = ../tb/tb.sv ../tb/host_agent_pkg.sv ../tb/sap1_env_pkg.sv

vcs:
	$(VCS) $(INCDIR) $(DESIGN) $(TB)

clean:
	rm -rf csrc simv simv.daidir vc_hdrs.h
