module datapath  #(parameter DATA_WIDTH = 16,ADDR_WIDTH = 3,PAR_WRITE = 1,PAR_READ = 1) 
                            (clk,wbuff,enr,data_in,empty,full,data_out);
        input clk,wbuff,enr;
        input [DATA_WIDTH*PAR_WRITE-1:0] data_in;
        output empty,full;
        output [DATA_WIDTH*PAR_READ -1: 0] data_out;

        wire [ADDR_WIDTH-1:0] w_pointer,r_pointer;
	wire [DATA_WIDTH - 1:0] buff [0:$pow(2, ADDR_WIDTH) - 1];

        counter_buffer #(ADDR_WIDTH,PAR_READ) r_counter (clk,enr,1'b0,r_pointer);
        counter_buffer #(ADDR_WIDTH,PAR_WRITE) w_counter (clk,wbuff,1'b0,w_pointer);
        buffer #(DATA_WIDTH,ADDR_WIDTH,PAR_WRITE,PAR_READ) buffer (clk,wbuff,w_pointer,r_pointer,data_in,data_out,buff);
        check_empty #(PAR_READ, ADDR_WIDTH) emp_check  (r_pointer, w_pointer,empty);
        check_full #(PAR_WRITE , ADDR_WIDTH) full_check (r_pointer, w_pointer,full);
endmodule