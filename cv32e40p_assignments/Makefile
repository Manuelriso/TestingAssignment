GATE_DIR      = $(CURDIR)/syn/out
TECHLIB_DIR   = $(CURDIR)/syn/techlib
export TB_DIR = $(CURDIR)/example_tb/core
export FIRMWARE      = $(CURDIR)/sbst/sbst.hex
export TB_CLK_NS     = 10.0
export SYN_CLK_NS    = 5.0

PYTHON          = python3
export VCS_WORK_DIR ?= $(CURDIR)/run/vcs
VC-Z01X_WORK_DIR ?= $(CURDIR)/run/vc-z01x
VCS ?= vcs
VERDI ?=
FSIM ?=
FUSA_SRC_PATH ?= $(CURDIR)/fsim
FAULT_TYPE ?= saf

ALL_VCS_FLAGS = $(if $(or $(VERDI),$(FSIM)), -kdb -debug_access+all -lca,) -sverilog -full64 -timescale=1ns/1ns $(if $(FSIM), $(FUSA_SRC_PATH)/strobe.sv -fsim -fsim=dut:tb_top.wrapper_i.top_i -fsim=portfaults +vcs+fsdbon ,) -suppress=TFIPC

# RTL source files
RTLSRC_HOME           := $(TB_DIR)/../..
export DESIGN_RTL_DIR  = $(RTLSRC_HOME)/rtl
CV_CORE_MANIFEST_FPU  := $(RTLSRC_HOME)/cv32e40p_fpu_manifest.flist
CV_CORE_MANIFEST_GATE := $(RTLSRC_HOME)/cv32e40p_manifest_gate.flist
RTLSRC_TB_PKG		  := $(TB_DIR)/include/perturbation_pkg.sv
RTLSRC_TB_TOP		  := $(TB_DIR)/tb_top.sv
RTLSRC_TB		      := $(filter-out $(TB_DIR)/cv32e40p_fp_wrapper.sv, $(wildcard $(TB_DIR)/*.sv))

RTLSRC_FPNEW_TB		  := $(wildcard $(TB_DIR)/*.sv)
RTLSRC_FPNEW_INCDIR	  := $(RTLSRC_HOME)/rtl/fpnew/src/common_cells/include
RTLSRC_FPNEW_PKG	  := $(RTLSRC_HOME)/rtl/fpnew/src/fpu_div_sqrt_mvp/hdl/defs_div_sqrt_mvp.sv $(RTLSRC_HOME)/rtl/fpnew/src/fpnew_pkg.sv $(RTLSRC_HOME)/rtl/fpnew/src/common_cells/src/cf_math_pkg.sv
RTLSRC_FPNEW		  := $(filter-out $(RTLSRC_HOME)/rtl/fpnew/src/fpnew_pkg.sv, $(wildcard $(RTLSRC_HOME)/rtl/fpnew/src/*.sv)) \
						 $(filter-out $(RTLSRC_HOME)/rtl/fpnew/src/fpu_div_sqrt_mvp/hdl/defs_div_sqrt_mvp.sv, $(wildcard $(RTLSRC_HOME)/rtl/fpnew/src/fpu_div_sqrt_mvp/hdl/*.sv)) \
						 $(RTLSRC_HOME)/rtl/fpnew/src/common_cells/src/rr_arb_tree.sv  $(RTLSRC_HOME)/rtl/fpnew/src/common_cells/src/lzc.sv


# ============== HELPERS ==============================


help::
	@printf "\033[1mSynthesis\033[0m\n"
	@printf "\033[31m\tsynthesis/nangate45\033[39m Invokes Synopsys Design Compiler to synthesize the CV32E40P using nangate45 as tech lib\n"
	@printf "\033[31m\tsynthesis/nangate45/scan_insertion \033[39m Invokes Synopsys Design Compiler to insert scan chains in CV32E40P (assuming Nangate as tech lib)\n"
	@printf "\033[1mCross Compile\033[0m\n"
	@printf "\033[31m\tcompile_sbst\033[39m Cross-Compiles your STL for the CV32E40P RISC-V ISA.\n"
	@printf "\033[1mLogic Simulation\033[0m\n"
	@printf "\033[31m\tvcs/comp/rtl\033[39m Invokes Synopsys VCS to compile CV32E40P RT-level description for functional logic simulation\n"
	@printf "\033[31m\tvcs/comp/gate\033[39m Invokes Synopsys VCS to compile CV32E40P Gate-level description for functional logic simulation\n"
	@printf "\033[31m\tvcs/sim/rtl/shell\033[39m Invokes Synopsys VCS to perform an RT-level simulation of the sbst in shell mode.\n"
	@printf "\033[31m\tvcs/sim/rtl/gui\033[39m Invokes Synopsys VCS/Verdi to perform an RT-level simulation of the sbst in gui mode.\n"
	@printf "\033[31m\tvcs/sim/gate/shell\033[39m Invokes Synopsys VCS to perform a Gate-level functional simulation of the sbst in shell mode.\n"
	@printf "\033[31m\tvcs/sim/gate/gui\033[39m Invokes Synopsys VCS/Verdi to perform a Gate-level functional simulation of the sbst in gui mode.\n"
	@printf "\033[1mFault Simulation\033[0m\n"
	@printf "\033[31m\tvcs/fsim/shell\033[39m Invokes VC-Z01X to perform a Gate-level functional fault simulation of the sbst in shell mode.\n"
	@printf "\033[31m\tvcs/fsim/gui\033[39m Invokes VC-Z01X/Verdi to perform a Gate-level functional fault simulation of the sbst in gui mode.\n"
	@printf "\033[1mOther\033[0m\n"
	@printf "\033[31m\tvcs/sim/clean\033[39m Cleans all run dirs of VCS.\n"
	@printf "\033[31m\tvcs/fsim/clean_all\033[39m Cleans all run dirs of VC-Z01X.\n"
	@printf "\033[31m\tvcs/fsim/clean_dbs\033[39m Cleans all fsim databases of VC-Z01X.\n"
	@printf "\033[31m\tvcs/clean_all\033[39m Cleans all run dirs/databases of VCS and VC-Z01X.\n"
	@printf "\033[31m\tdistclean\033[39m Cleans all run/ dirs and sbst/.\n"

# ============== SYNTHESIS ==============================

synthesis/nangate45:
	
	bash syn/bin/run_syn.sh NangateOpenCellLibrary

synthesis/nangate45/scan_insertion:
	
	bash syn/bin/run_scan_insertion.sh

# ================== VCS / VC-Z01X / VERDI ===========================

vcs/sim/clean:
	rm -rf $(VCS_WORK_DIR)
vcs/fsim/clean_all:
	rm -rf $(VC-Z01X_WORK_DIR)/*
vcs/fsim/clean_dbs:
	rm -rf $(VC-Z01X_WORK_DIR)/fdb $(VC-Z01X_WORK_DIR)/fcm.dir $(VC-Z01X_WORK_DIR)/fcm_tsim_fsdb 
vcs/clean_all: vcs/sim/clean vcs/fsim/clean_all

vcs/comp/rtl: vcs/sim/clean
	mkdir -p $(VCS_WORK_DIR)
	cd $(VCS_WORK_DIR) &&\
	$(VCS) -f $(CV_CORE_MANIFEST_FPU) $(RTLSRC_TB_PKG) $(RTLSRC_TB) $(ALL_VCS_FLAGS) \
		-top tb_top $(if $(FSIM), -top strobe,)

vcs/comp/gate: vcs/sim/clean
	mkdir -p $(VCS_WORK_DIR)
	cd $(VCS_WORK_DIR) &&\
	$(VCS) -v $(TECHLIB_DIR)/NangateOpenCellLibrary.v \
		-f $(CV_CORE_MANIFEST_GATE) $(RTLSRC_TB_PKG) $(RTLSRC_TB) $(ALL_VCS_FLAGS) \
		-top tb_top $(if $(FSIM), -top strobe,)

--vcs/sim: compile_sbst
	cd $(VCS_WORK_DIR) &&\
	./simv +firmware=$(FIRMWARE) $(if $(VERDI), -gui -do $(CURDIR)/gui.do,)

--vcs/sim/rtl: vcs/comp/rtl --vcs/sim

vcs/sim/rtl/gui: export VERDI=1
vcs/sim/rtl/gui: --vcs/sim/rtl
vcs/sim/rtl/shell: --vcs/sim/rtl

--vcs/sim/gate: vcs/comp/gate --vcs/sim

vcs/sim/gate/gui: export VERDI=1
vcs/sim/gate/gui: --vcs/sim/gate
vcs/sim/gate/shell: --vcs/sim/gate

--vcs/fgen: vcs/fsim/clean_all vcs/comp/gate
	mkdir -p $(VC-Z01X_WORK_DIR) &&\
	cd $(VC-Z01X_WORK_DIR) &&\
	vc_fcc -full64 -daidir $(VCS_WORK_DIR)/simv.daidir \
		-sff $(FUSA_SRC_PATH)/config.sff,$(FUSA_SRC_PATH)/gen_$(FAULT_TYPE)_cv32e40p_top.sff \
		-report $(VC-Z01X_WORK_DIR)/cv32e40p_top_$(FAULT_TYPE).rpt -campaign cv32e40p -overwrite \
		-collapse off &&\
	cp $(VC-Z01X_WORK_DIR)/cv32e40p_top_$(FAULT_TYPE).rpt $(VC-Z01X_WORK_DIR)/faults.ssf

--vcs/fsim/fcc: --vcs/fgen
	cd $(VC-Z01X_WORK_DIR) &&\
	vc_fcc -full64 -daidir $(VCS_WORK_DIR)/simv.daidir \
		-sff $(FUSA_SRC_PATH)/config.sff,$(VC-Z01X_WORK_DIR)/faults.ssf \
		-campaign cv32e40p -overwrite

--vcs/fsim/fcm: 
	cd $(VC-Z01X_WORK_DIR) &&\
	vc_fcm -connect -campaign cv32e40p \
		-tcl_script $(FUSA_SRC_PATH)/fcm.tcl 

--vcs/fsim: export FSIM=1 
--vcs/fsim: vcs/comp/gate compile_sbst vcs/fsim/clean_dbs --vcs/fsim/fcc --vcs/fsim/fcm
	$(if $(VERDI), verdi -fdb_path $(VC-Z01X_WORK_DIR)/fdb -fdb_project default -campaign cv32e40p,)

vcs/fsim/gui: export VERDI=1
vcs/fsim/gui: --vcs/fsim
vcs/fsim/shell: --vcs/fsim

# ============== SBST ==============================

compile_sbst:

	$(MAKE) -C $(CURDIR)/sbst

# ============== UTILS =============================

distclean: 
	rm -vfr $(CURDIR)/run/*
	rm -vfr $(CURDIR)/syn/run/*
	rm -vfr $(GATE_DIR)/run/*
	rm -vfr $(GATE_DIR)/*gsf*
	$(MAKE) -C $(CURDIR)/sbst clean 
	$(MAKE) -C $(TB_DIR) clean 
