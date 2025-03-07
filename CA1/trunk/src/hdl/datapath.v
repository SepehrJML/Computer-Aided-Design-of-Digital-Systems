module datapth #(parameter N = 16 , K = 3) (clk,rst,clr,clrA,clrB,cnten,ldcnt,shenA,cntenA,cntenB,inpRAMen
                                ,sel,shenB,enA,enB,outRAMen,ldshA,ldshB,check_sh,done,ov,ov_cnt32);
    input clk,rst,clr,clrA,clrB,cnten,ldcnt,shenA,cntenA,cntenB,inpRAMen,sel,shenB,enA,enB,outRAMen,ldshA,ldshB,done;
    output check_sh,ov,ov_cnt32;

    wire [2*N-1:0] result;
    wire [K:0] addr,out_counter16,num_worthless_A,num_worthless_B;
    wire [K+1:0] num_worthless_res,dummy;
    wire [N-1:0] out_shift16,first_num,second_num,out_mux,mul_res,useful_A,useful_B;
    wire ov_cnt16;

    counter main_counter (.clk(clk),.rst(rst),.clr(clr),.cnten(cnten),.out(addr),.ov(ov),.ld(1'b0),.in(0));
    iput_ram inRAM(.clk(clk),.rst(rst),.inpRAMen(inpRAMen),.addr(addr),.a(first_num),.b(second_num));
    mux MUX(.sel(sel),.a(first_num),.b(second_num),.w(out_mux));
    shift_reg #(.N(N)) shift16 (.clk(clk),.rst(rst),.clr(clrA),.in(out_mux),.ld(ldshA),.shen(shenA),.out(out_shift16));
    counter counter16 (.clk(clk),.rst(rst),.clr(clrB),.cnten(cntenA),.out(out_counter16),.ov(ov_cnt16),.ld(1'b0),.in(0));
    register regA(.clk(clk),.rst(rst),.en(enA),.num_worthless_in(out_counter16),.useful_in(out_shift16)
            ,.num_worthless_out(num_worthless_A),.useful_out(useful_A));
    register regB(.clk(clk),.rst(rst),.en(enB),.num_worthless_in(out_counter16),.useful_in(out_shift16)
            ,.num_worthless_out(num_worthless_B),.useful_out(useful_B));
    mul mul(.a(useful_A),.b(useful_B),.w(mul_res));
    adder add_worthless(.a(num_worthless_A),.b(num_worthless_B),.w(num_worthless_res));
    shift_reg #(.N(2*N)) shift32 (.clk(clk),.rst(rst),.clr(clrA),.in({{N{1'b0}},mul_res}),.ld(ldshB),.shen(shenB),.out(result));
    counter #(.N(K+2))  counter32 (.clk(clk),.rst(rst),.clr(clrA),.cnten(cntenB),.out(dummy),
                        .ov(ov_cnt32),.ld(ldcnt),.in(num_worthless_res));
    output_ram outRAM(.clk(clk),.rst(rst),.clr(clr),.done(done),.addr(addr),.result(result)
                    ,.outRAMen(outRAMen));

    assign check_sh = (out_shift16[N-1] | ov_cnt16);
endmodule