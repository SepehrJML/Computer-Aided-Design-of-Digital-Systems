`timescale 1ns/1ns
module TB #(parameter DATA_WIDTH=16,ADDR_WIDTH_IFM=4,ADDR_WIDTH_FIL=5,S=3,F=3,PAR_WRITE=1,PAR_READ=1,FIL_DEPTH=16) ();
    reg clk=0,start=0,w_en_ifm=0,w_en_fil=0,r_en =0;
    reg [DATA_WIDTH*PAR_WRITE+1:0] data_in_ifm;
    reg [DATA_WIDTH*PAR_WRITE-1:0] data_in_fil;
    reg [S-1:0] stride=3'b100;
    reg [F-1:0] filter_size=3'b100;
    wire [DATA_WIDTH*PAR_READ-1:0] out;
    wire done,valid,ready_ifm,ready_fil;
    pe #(DATA_WIDTH,ADDR_WIDTH_IFM,ADDR_WIDTH_FIL,S,F,PAR_WRITE,PAR_READ,FIL_DEPTH) test
        (clk , start,r_en,w_en_ifm,w_en_fil,data_in_ifm,data_in_fil,
        stride,filter_size,
        out, done,valid,ready_ifm,ready_fil);
    always #5 clk=~clk;
    reg [DATA_WIDTH-1:0] data=1;

    reg [DATA_WIDTH+1 : 0] data_ifmap [0 : 15];
    reg [DATA_WIDTH-1 : 0] data_filter [0 : 15];
    reg [DATA_WIDTH-1:0] data_output [0:23];
    integer s=0,true_=0;
    integer k =9;
    initial begin
        $readmemb("file/test_1_ifmap.txt", data_ifmap);
        $readmemb("file/test_1_filter.txt", data_filter);
        $readmemb("file/test_1_psum.txt", data_output);
        #400 start = 1;
        #300 start = 0;
        #10
        data_in_fil = data_filter[0];
        w_en_fil = 1;
        data_in_ifm = data_ifmap[0];
        w_en_ifm = 1;
        #19
        w_en_fil = 0;
        w_en_ifm = 0;
        #19
        data_in_fil = data_filter[1];
        w_en_fil = 1;
        data_in_ifm = data_ifmap[1];
        w_en_ifm = 1;
        #500
        w_en_fil = 0;
        w_en_ifm = 0;
        #100
        data_in_fil = data_filter[2];
        w_en_fil = 1;
        #30
        w_en_fil = 0;
        #19
        data_in_fil = data_filter[3];
        w_en_fil = 1;
        data_in_ifm = data_ifmap[2];
        w_en_ifm = 1;
        #500
        w_en_fil = 0;
        w_en_ifm = 0;
        #19
        data_in_fil = data_filter[4];
        w_en_fil = 1;
        data_in_ifm = data_ifmap[3];
        w_en_ifm = 1;
        #500
        w_en_fil = 0;
        w_en_ifm = 0;
        #100
        data_in_ifm = data_ifmap[4];
        #100
        w_en_ifm = 1;
        #500
        w_en_ifm = 0;
        #19
        data_in_fil = data_filter[5];
        w_en_fil = 1;
        data_in_ifm = data_ifmap[5];
        w_en_ifm = 1;
        #500
        w_en_fil = 0;
        w_en_ifm = 0;
        #19
        data_in_fil = data_filter[6];
        w_en_fil = 1;
        data_in_ifm = data_ifmap[6];
        w_en_ifm = 1;
        #500
        w_en_fil = 0;
        w_en_ifm = 0;
        #100
        data_in_ifm = data_ifmap[7];
        #100
        w_en_ifm = 1;
        #500
        w_en_ifm = 0;
        #19
        data_in_fil = data_filter[7];
        w_en_fil = 1;
        data_in_ifm = data_ifmap[8];
        w_en_ifm = 1;
        #500
        w_en_fil = 0;
        w_en_ifm = 0;
        #100
        data_in_fil = data_filter[8];
        w_en_fil = 1;
        #30
        w_en_fil = 0;
        repeat (7) begin
            #190
            data_in_fil = data_filter[7];
            w_en_fil = 1;
            data_in_ifm = data_ifmap[8];
            w_en_ifm = 1;
            #190
            w_en_fil = 0;
            w_en_ifm = 0;
            k++;
        end
        #3000
        repeat (16) begin
        #1000 r_en = 1;
        #1200 r_en =0;
        end
        #5000 $stop;
    end
    always @(posedge valid) begin
        if (data_output[s] == out) begin
            true_++;
        end
        s++;
    end
endmodule