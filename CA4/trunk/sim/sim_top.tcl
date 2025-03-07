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
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/add.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/buffer.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/check_empty.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/check_full.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/counter.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/counter_addr.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/counter_filter.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/datapath_pe.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/fifo_buffer.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/input_read_controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mul.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mul_addr.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mux.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/output_write_controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/PE.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/read_controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/reg_pipe.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/register.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/RT_ScratchPad.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/ST_ScratchPad.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/write_controller.v
		
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./tb/$TB.sv
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
	