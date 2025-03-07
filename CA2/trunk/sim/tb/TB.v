`timescale 1ns/1ns
module TB # (parameter DATA_WIDTH = 16,ADDR_WIDTH = 3,PAR_WRITE = 2,PAR_READ = 1 ) ();
	reg clk=0,w_en=0,r_en=0;
	reg[DATA_WIDTH*PAR_WRITE-1:0] data_in=0;
	wire ready,valid;
	wire [DATA_WIDTH*PAR_READ-1:0] data_out;
	
	fifo_buffer #(DATA_WIDTH,ADDR_WIDTH,PAR_WRITE,PAR_READ) test(clk,w_en,r_en,data_in,ready,valid,data_out);
	
	always #10 clk=~clk;
        initial begin
            #125 r_en=1;
            #500 r_en=0;
	    #500 data_in = data_in + 1;
	    #7000 w_en=1;
            #500 w_en=0;
	    #500 data_in = data_in + 1;
	    #500 data_in = data_in + 1;
	    #7000 w_en=1;
            #500 w_en=0;
	    #500 data_in = data_in + 1;
            #125 r_en=1;
            #500 r_en=0; 
	    #500 data_in = data_in + 1;
	    #7000 r_en=1;
            #500 r_en=0;
	    #500 data_in = data_in + 1;
	    #7000 w_en=1; 
            #500 w_en=0; 
	    #500 data_in = data_in + 1;
	    #7000 w_en=1; 
            #500 w_en=0; 
	    #500 data_in = data_in + 1;
	    #7000 w_en=1;
            #500 w_en=0;
		data_in = data_in + 1;
	    #7000 w_en=1; r_en=1;
            #500 w_en=0;  r_en=0;
            #125 
            #500
	    #500 data_in = data_in + 1;
            #125 r_en=1;
            #500 r_en=0;
	    #500 data_in = data_in + 1;
            #125 r_en=1;
            #500 r_en=0;
	    #500 data_in = data_in + 1;
            #125 r_en=1;
            #500 r_en=0;
	    #500 data_in = data_in + 1;
            #125 r_en=1;
            #500 r_en=0;
	    #500 data_in = data_in + 1;
	    #7000 w_en=1;
            #500 w_en=0;
	    #7000 w_en=1;
            #500 w_en=0;
	    #7000 w_en=1;
            #500 w_en=0;
	    #7000 w_en=1;
            #500 w_en=0;
            #100000 $stop;
        end
endmodule
