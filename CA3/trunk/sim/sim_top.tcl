	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"TB"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
#	set run_time			"1 us"
	set run_time			"-all"

#============================ Add verilog files  ===============================
# Pleas add other module here	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/adder_fpga.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/and.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/controller_fpga.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/datapath_fpga.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/downcounter.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/FA.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/HA.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/modules.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mul_fpga.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mul.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/not.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/or.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/right_shift.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/shift_reg.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/top.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/upcounter.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/xor.v
		
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./tb/$TB.v
	onerror {break}

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB $TB


#======================= adding signals to wave window ==========================


	add wave -hex -group 	 	{TB}				sim:/$TB/*
	add wave -hex -group 	 	{top}				sim:/$TB/uut/*	
	add wave -hex -group -r		{all}				sim:/$TB/*

#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
    

#====================================== run =====================================

	run $run_time 
	