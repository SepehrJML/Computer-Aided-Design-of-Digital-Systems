`timescale 1ns/1ns
module TB();
	reg clk=0,start=0,rst=0;
	reg [15:0] Ain,Bin;
	wire done;
	wire [15:0] Yout;
	top test (clk,rst,start,Ain,Bin,Yout,done); 
	always #30 clk=~clk;
	
	initial begin
		#200 Ain=16'd127;
		     Bin=16'd255;
		#200 rst=1;
		#200 rst=0;
		#200 start = 1'b1;
		#150 start = 1'b0;
		#5000
		#200 rst=1;
		#200 rst=0;
		#200 Ain=16'd11903;
		     Bin=16'd2753;
		#200 start = 1'b1;
		#150 start = 1'b0;
		#5000
		#200 rst=1;
		#200 rst=0;
		#200 Ain=16'd65535;
		     Bin=16'd65535;
		#200 start = 1'b1;
		#150 start = 1'b0;
		#100000 $stop;
	end
endmodule
