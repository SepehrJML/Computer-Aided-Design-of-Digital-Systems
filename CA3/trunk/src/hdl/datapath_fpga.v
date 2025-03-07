module datapath_fpga #(parameter N=16,M=4) (input clk,clr,ld,ldA,enA,enB,enC,input [N-1:0] Ain,Bin,output check_ovA,check_ovB,Co0,Co,output [N-1:0] Yout);
	wire [N-1:0] out_shA,out_shB,in_shregY;
	wire ovCountA,ovCountB;
	wire [M-1:0] out_countA,out_countB;
	wire [M:0] in_countY,out_countY,r;
	shift_register A(clk,1'b0,Ain,enA,ldA,out_shA);
	shift_register B(clk,1'b0,Bin,enB,ldA,out_shB);
	upcounter countA (clk,clr,enA,out_countA,ovCountA);
	upcounter countB (clk,clr,enB,out_countB,ovCountB);
    custom_or Aa(ovCountA,out_shA[N-1],check_ovA);
    custom_or Bb(ovCountA,out_shB[N-1],check_ovB);
    custom_and Cc(check_ovA,check_ovB,Co0);
	mul_fpga mul (out_shA[15:8],out_shB[15:8],in_shregY);
	adder_fpga adder (out_countA,out_countB,in_countY);
	right_shift W(clk,clr,in_shregY,enC,ld,Yout);
	downcounter countW (clk,in_countY,ld,clr,enC,out_countY,Co);
endmodule
