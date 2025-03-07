module pe #(parameter DATA_WIDTH=8,ADDR_WIDTH_IFM=4,ADDR_WIDTH_FIL=3,S=2,F=2,PAR_WRITE=1,PAR_READ=1,FIL_DEPTH=16) 
        (input clk , start,r_en,w_en_ifm,w_en_fil,w_en_psum,acum,input [DATA_WIDTH*PAR_WRITE+1:0]data_in_ifm,input [DATA_WIDTH*PAR_WRITE-1:0] data_in_fil,
        input [2*DATA_WIDTH-1:0] data_in_psum,input [S-1:0] stride,
        input[F-1:0] filter_size,input [1:0] mode,output [(2*DATA_WIDTH-1)*PAR_READ-1:0] out,output done,valid,ready_ifm,ready_fil,ready_psum);
    wire empty,stall,ov0,ov1,ov2,ov,clr,clr0,clr1,clr2,ctrl_en,en,en0,en1,en2,ld,en_all,clrW,is_zero;
    controller ctrl(clk,start,empty,stall,ov0,ov1,ov2,ov
             ,clr,clrW,clr0,clr1,clr2,mode,is_zero,ctrl_en,en,en0,en1,en2,ld,en_all,done);
    datapath_pe #(DATA_WIDTH,ADDR_WIDTH_IFM,ADDR_WIDTH_FIL,S,F,PAR_WRITE,PAR_READ,FIL_DEPTH) dp_pe
        (clk,en_all,r_en,ld,en0,en1,en2,clr,clrW,clr0,clr1,clr2,is_zero,en,w_en_ifm
        ,w_en_fil,w_en_psum,done,ctrl_en,acum,mode,data_in_ifm,data_in_fil,data_in_psum,stride,
        filter_size,out,valid,empty,stall,ready_ifm,ready_fil,ready_psum,ov0,ov1,ov2,ov);
endmodule