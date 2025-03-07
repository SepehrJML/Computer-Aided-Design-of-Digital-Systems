`timescale 1ns/1ns
module TB #(parameter DATA_WIDTH=16,ADDR_WIDTH_IFM=4,ADDR_WIDTH_FIL=5,S=3,F=4,PAR_WRITE=1,PAR_READ=1,FIL_DEPTH=10) ();
    reg clk=0,start=0,w_en_ifm=0,w_en_fil=0,w_en_psum=0,r_en =0,acum=0;
    reg [DATA_WIDTH*PAR_WRITE+1:0] data_in_ifm;
    reg [DATA_WIDTH*PAR_WRITE-1:0] data_in_fil;
    reg [DATA_WIDTH-1:0] data_in_psum;
    reg [S-1:0] stride=3'b001;
    reg [F-1:0] filter_size=4'b0101;
    reg [1:0] mode=2'b10;
    wire [(2*DATA_WIDTH-1)*PAR_READ-1:0] out;
    wire done,valid,ready_ifm,ready_fil,ready_psum;
    pe #(DATA_WIDTH,ADDR_WIDTH_IFM,ADDR_WIDTH_FIL,S,F,PAR_WRITE,PAR_READ,FIL_DEPTH) test
        (clk , start,r_en,w_en_ifm,w_en_fil,w_en_psum,acum,data_in_ifm,data_in_fil,data_in_psum,
        stride,filter_size,mode,
        out, done,valid,ready_ifm,ready_fil,ready_psum);
    always #5 clk=~clk;
    reg [2*DATA_WIDTH-1:0] data_output [0:23];
    integer k =0;

    initial begin
        $readmemb("file/data_mode3.txt", data_output);
        #200 start =1;
        #200 start =0;
        repeat (10) begin
            #200    data_in_fil = data_output[k][DATA_WIDTH-1 : 0];
                    w_en_fil = 1;
            #200    w_en_fil= 0;
                k++;
        end
        repeat (1) begin
            #200    data_in_ifm = {2'b10,data_output[k][DATA_WIDTH-1 : 0]};
                    w_en_ifm = 1;
            #200    w_en_ifm= 0;
                    k++;
            repeat (10) begin
                #200    data_in_ifm = {2'b00,data_output[k][DATA_WIDTH-1 : 0]};
                        w_en_ifm = 1;
                #200    w_en_ifm= 0;
                        k++;      
            end
            #200    data_in_ifm = {2'b01,data_output[k][DATA_WIDTH-1 : 0]};
                    w_en_ifm = 1;
            #200    w_en_ifm= 0;
                    k++;
        end
        #3000
        repeat (16) begin
        #1000 r_en = 1;
        #1200 r_en =0;
        end
        #5000 $stop;
    end
endmodule