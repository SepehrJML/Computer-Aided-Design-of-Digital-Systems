module top #(parameter N=16) (input clk,rst,start,input [N-1:0] Ain,Bin,output [N-1:0] Yout,output done); 
	wire clr,ld,ldA,enA,enB,enC,check_ovA,check_ovB,Co0,Co;

	datapath_fpga dp(clk,clr,ld,ldA,enA,enB,enC,Ain,Bin,check_ovA,check_ovB,Co0,Co,Yout);
	controller_fpga ctrl( clk,rst,start,check_ovA,check_ovB,Co0,Co,clr,ld,ldA,enA,enB,enC,done);
endmodule
