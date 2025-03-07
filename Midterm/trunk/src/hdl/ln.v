module ln #(parameter N=32,L=8,M=3) (input clk,reset,start,input [L-1:0] Xin,input[M-1:0] Nin,output [N-1:0] Y,output ready,valid,overflow,error);
    wire rstS1,rstS2,rstS3,rstS4,sel_initS1,sel_initS2,sel_initS3,sel_initS4,valid_dp,ov_dp;
    datapath dp(clk,1'b1,reset,rstS1,rstS2,rstS3,rstS4,sel_initS1,sel_initS2,sel_initS3,
                    sel_initS4,Xin,Nin,ov_dp,valid_dp,error,Y);
    controller ctrl(clk,reset,start,valid_dp,ov_dp,rstS1,rstS2,rstS3,
    rstS4,ready,valid,overflow,sel_initS1,sel_initS2,sel_initS3,sel_initS4);
endmodule
