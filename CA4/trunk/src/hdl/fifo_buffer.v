module fifo_buffer #(parameter DATA_WIDTH = 16,ADDR_WIDTH = 3,PAR_WRITE = 1,PAR_READ = 1) 
    (clk,w_en,r_en,data_in,ready,valid,data_out);
    input clk,w_en,r_en;
    input [DATA_WIDTH*PAR_WRITE -1 :0] data_in;
    output ready,valid;
    output [DATA_WIDTH*PAR_READ -1:0] data_out;   

    wire enr,wbuff;

    datapath #(DATA_WIDTH,ADDR_WIDTH,PAR_WRITE,PAR_READ) dp (clk,wbuff,enr,data_in,empty,full,data_out);
    write_controller wc(clk, w_en, full,ready, wbuff);
    read_controller rc(clk, r_en, empty,valid, enr);      
endmodule