module datapath #(parameter N=32,K=16,M=3) (input clk,en,rst_main,rstS1,rstS2,rstS3,rstS4,sel_initS1,sel_initS2,sel_initS3,sel_initS4,input [7:0] Xin,input[M-1:0] Nin,output overflow,valid,error,output [N-1:0] Y);

    wire [N-1:0] y_out_S1,out_mux_res_S1,ResS1,ResOutS1,out_lshift_S1;
    wire [K-1:0] x_in_S1,x_pow_in_S1,x_out_S1,x_pow_out_S1,out_ROM_S1,out_mux_xpow_S1,
            out_mux_x_S1,XiOutS1,out_rshift_S1,Xin16S1;
    wire [2*K-2:0] out_mul_x_S1,out_mul_kx_S1;
    wire [M-1:0] addr_in_S1,addr_out_S1,out_addrplus_S1,twocomp_addr_S1,check_zero_S1,new_addr_out_S1;
    wire na_cout1S1,na_cout2S1,na_cout3S1,ovfS1;
    wire sel_in_S1,sel_out_S1,ovf_in_S1,ovf_out_S1;

    wire [N-1:0] y_out_S2,out_mux_res_S2,ResS2,ResOutS2,out_lshift_S2;
    wire [K-1:0] x_in_S2,x_pow_in_S2,x_out_S2,x_pow_out_S2,out_ROM_S2,out_mux_xpow_S2,
            out_mux_x_S2,XiOutS2,out_rshift_S2,Xin16S2;
    wire [2*K-2:0] out_mul_x_S2,out_mul_kx_S2;
    wire [M-1:0] addr_in_S2,addr_out_S2,out_addrplus_S2,twocomp_addr_S2,check_zero_S2,new_addr_out_S2;
    wire na_cout1S2,na_cout2S2,na_cout3S2,ovfS2;
    wire sel_in_S2,sel_out_S2,ovf_in_S2,ovf_out_S2;

    wire [N-1:0] y_out_S3,out_mux_res_S3,ResS3,ResOutS3,out_lshift_S3;
    wire [K-1:0] x_in_S3,x_pow_in_S3,x_out_S3,x_pow_out_S3,out_ROM_S3,out_mux_xpow_S3,
            out_mux_x_S3,XiOutS3,out_rshift_S3,Xin16S3;
    wire [2*K-2:0] out_mul_x_S3,out_mul_kx_S3;
    wire [M-1:0] addr_in_S3,addr_out_S3,out_addrplus_S3,twocomp_addr_S3,check_zero_S3,new_addr_out_S3;
    wire na_cout1S3,na_cout2S3,na_cout3S3,ovfS3;
    wire sel_in_S3,sel_out_S3,ovf_in_S3,ovf_out_S3;

    wire [N-1:0] y_out_S4,out_mux_res_S4,ResS4,ResOutS4,out_lshift_S4;
    wire [K-1:0] x_in_S4,x_pow_in_S4,x_out_S4,x_pow_out_S4,out_ROM_S4,out_mux_xpow_S4,
            out_mux_x_S4,XiOutS4,out_rshift_S4,Xin16S4;
    wire [2*K-2:0] out_mul_x_S4,out_mul_kx_S4;
    wire [M-1:0] addr_in_S4,addr_out_S4,out_addrplus_S4,twocomp_addr_S4,check_zero_S4,new_addr_out_S4;
    wire na_cout1S4,na_cout2S4,na_cout3S4,ovfS4;
    wire sel_in_S4,sel_out_S4,ovf_in_S4,ovf_out_S4;
    //S1---------------------------------
    register regS1 (clk,rstS1,rst_main,en,sel_out_S4,ovf_out_S4,Xin16S1,out_mux_x_S4,XiOutS4,ResOutS4,
    new_addr_out_S4,sel_in_S1,ovf_in_S1,
    x_out_S1,x_pow_out_S1,y_out_S1, addr_out_S1);
    lshift #(16,8) xshS1 (Xin,Xin16S1);
    rom romS1 (addr_out_S1,out_ROM_S1);
    mux muxResInS1  (sel_initS1,y_out_S1,32'b0,out_mux_res_S1);
    mux #(16) muxXpowInS1 (sel_initS1,x_pow_out_S1,16'b0111111111111111,out_mux_xpow_S1);
    mux #(16) muxXInS1 (sel_initS1,x_out_S1,Xin16S1,out_mux_x_S1);
    mul mulxiS1 (out_mux_xpow_S1,out_mux_x_S1,out_mul_x_S1);
    mul mulkxS1 (out_ROM_S1,out_rshift_S1,out_mul_kx_S1);
    adder #(M) addrplusS1 (addr_out_S1,3'b001,out_addrplus_S1,na_cout1S1);
    adder #(M) twocompaddrS1 (~addr_out_S1,3'b001,twocomp_addr_S1,na_cout2S1);
    adder #(M) check_ovS1 (Nin,twocomp_addr_S1,check_zero_S1,na_cout3S1);
    adder addResS1 (out_lshift_S1,out_mux_res_S1,ResS1,ovfS1);
    mux #(M) countS1 (sel_out_S1,out_addrplus_S1,addr_out_S1,new_addr_out_S1);
    mux muxOutResS1 (sel_in_S1,ResS1,out_mux_res_S1,ResOutS1);
    mux #(16) muxOutxiS1 (sel_in_S1,out_rshift_S1,out_mux_xpow_S1,XiOutS1);
    lshift lshS1 (out_mul_kx_S1,out_lshift_S1);
    rshift rshS1 (out_mul_x_S1,out_rshift_S1);

    assign sel_out_S1 = ~(|(check_zero_S1));
    assign ovf_out_S1 = (ovfS1 | ovf_in_S1);
    //S2------------------------------------------------------

    register regS2 (clk,rstS2,rst_main,en,sel_out_S1,ovf_out_S1,Xin16S2,out_mux_x_S1,XiOutS1,ResOutS1,
    new_addr_out_S1,sel_in_S2,ovf_in_S2,
    x_out_S2,x_pow_out_S2,y_out_S2, addr_out_S2);
    lshift #(16,8) xshS2 (Xin,Xin16S2);
    rom romS2 (addr_out_S2,out_ROM_S2);
    mux muxResInS2  (sel_initS2,y_out_S2,32'b0,out_mux_res_S2);
    mux #(16) muxXpowInS2 (sel_initS2,x_pow_out_S2,16'b0111111111111111,out_mux_xpow_S2);
    mux #(16) muxXInS2 (sel_initS2,x_out_S2,Xin16S2,out_mux_x_S2);
    mul mulxiS2 (out_mux_xpow_S2,out_mux_x_S2,out_mul_x_S2);
    mul mulkxS2 (out_ROM_S2,out_rshift_S2,out_mul_kx_S2);
    adder #(M) addrplusS2 (addr_out_S2,3'b001,out_addrplus_S2,na_cout1S2);
    adder #(M) twocompaddrS2 (~addr_out_S2,3'b001,twocomp_addr_S2,na_cout2S2);
    adder #(M) check_ovS2 (Nin,twocomp_addr_S2,check_zero_S2,na_cout3S2);
    adder addResS2 (out_lshift_S2,out_mux_res_S2,ResS2,ovfS2);
    mux #(M) countS2 (sel_out_S2,out_addrplus_S2,addr_out_S2,new_addr_out_S2);
    mux muxOutResS2 (sel_in_S2,ResS2,out_mux_res_S2,ResOutS2);
    mux #(16) muxOutxiS2 (sel_in_S2,out_rshift_S2,out_mux_xpow_S2,XiOutS2);
    lshift lshS2 (out_mul_kx_S2,out_lshift_S2);
    rshift rshS2 (out_mul_x_S2,out_rshift_S2);

    assign sel_out_S2 = ~(|(check_zero_S2));
    assign ovf_out_S2 = (ovfS2 | ovf_in_S2);
    //S3----------------------------------------------

    register regS3 (clk,rstS3,rst_main,en,sel_out_S2,ovf_out_S2,Xin16S3,out_mux_x_S2,XiOutS2,ResOutS2,
    new_addr_out_S2,sel_in_S3,ovf_in_S3,
    x_out_S3,x_pow_out_S3,y_out_S3, addr_out_S3);
    lshift #(16,8) xshS3 (Xin,Xin16S3);
    rom romS3 (addr_out_S3,out_ROM_S3);
    mux muxResInS3  (sel_initS3,y_out_S3,32'b0,out_mux_res_S3);
    mux #(16) muxXpowInS3 (sel_initS3,x_pow_out_S3,16'b0111111111111111,out_mux_xpow_S3);
    mux #(16) muxXInS3 (sel_initS3,x_out_S3,Xin16S3,out_mux_x_S3);
    mul mulxiS3 (out_mux_xpow_S3,out_mux_x_S3,out_mul_x_S3);
    mul mulkxS3 (out_ROM_S3,out_rshift_S3,out_mul_kx_S3);
    adder #(M) addrplusS3 (addr_out_S3,3'b001,out_addrplus_S3,na_cout1S3);
    adder #(M) twocompaddrS3 (~addr_out_S3,3'b001,twocomp_addr_S3,na_cout2S3);
    adder #(M) check_ovS3 (Nin,twocomp_addr_S3,check_zero_S3,na_cout3S3);
    adder addResS3 (out_lshift_S3,out_mux_res_S3,ResS3,ovfS3);
    mux #(M) countS3 (sel_out_S3,out_addrplus_S3,addr_out_S3,new_addr_out_S3);
    mux muxOutResS3 (sel_in_S3,ResS3,out_mux_res_S3,ResOutS3);
    mux #(16) muxOutxiS3 (sel_in_S3,out_rshift_S3,out_mux_xpow_S3,XiOutS3);
    lshift lshS3 (out_mul_kx_S3,out_lshift_S3);
    rshift rshS3 (out_mul_x_S3,out_rshift_S3);

    assign sel_out_S3 = ~(|(check_zero_S3));
    assign ovf_out_S3 = (ovfS3 | ovf_in_S3);
    //S4-------------------------------------------------------------

    register regS4 (clk,rstS4,rst_main,en,sel_out_S3,ovf_out_S3,Xin16S4,out_mux_x_S3,XiOutS3,ResOutS3,
    new_addr_out_S3,sel_in_S4,ovf_in_S4,
    x_out_S4,x_pow_out_S4,y_out_S4, addr_out_S4);
    lshift #(16,8) xshS4 (Xin,Xin16S4);
    rom romS4 (addr_out_S4,out_ROM_S4);
    mux muxResInS4  (sel_initS4,y_out_S4,32'b0,out_mux_res_S4);
    mux #(16) muxXpowInS4 (sel_initS4,x_pow_out_S4,16'b0111111111111111,out_mux_xpow_S4);
    mux #(16) muxXInS4 (sel_initS4,x_out_S4,Xin16S4,out_mux_x_S4);
    mul mulxiS4 (out_mux_xpow_S4,out_mux_x_S4,out_mul_x_S4);
    mul mulkxS4 (out_ROM_S4,out_rshift_S4,out_mul_kx_S4);
    adder #(M) addrplusS4 (addr_out_S4,3'b001,out_addrplus_S4,na_cout1S4);
    adder #(M) twocompaddrS4 (~addr_out_S4,3'b001,twocomp_addr_S4,na_cout2S4);
    adder #(M) check_ovS4 (Nin,twocomp_addr_S4,check_zero_S4,na_cout3S4);
    adder addResS4 (out_lshift_S4,out_mux_res_S4,ResS4,ovfS4);
    mux #(M) countS4 (sel_out_S4,out_addrplus_S4,addr_out_S4,new_addr_out_S4);
    mux muxOutResS4 (sel_in_S4,ResS4,out_mux_res_S4,ResOutS4);
    mux #(16) muxOutxiS4 (sel_in_S4,out_rshift_S4,out_mux_xpow_S4,XiOutS4);
    lshift lshS4 (out_mul_kx_S4,out_lshift_S4);
    rshift rshS4 (out_mul_x_S4,out_rshift_S4);

    assign sel_out_S4 = ~(|(check_zero_S4));
    assign ovf_out_S4 = (ovfS4 | ovf_in_S4);

    assign valid = sel_out_S4;
    assign overflow = ovf_out_S4;
    assign Y = ResOutS4;
    
    assign error = (x_out_S4 == 16'b1000000100000000) | (x_out_S4 == 16'b1000000000000000);
endmodule