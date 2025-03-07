`timescale 1ns/1ns
module top_module(clk,rst,start,done);
    input clk,rst,start;
    output done;

    wire clr,clrA,clrB,cnten,ldcnt,shenA,cntenA,cntenB,inpRAMen
        ,sel,shenB,enA,enB,outRAMen,ldshA,ldshB,check_sh,ov,ov_cnt32;

    datapth dp (.clk(clk),.rst(rst),.clr(clr),.clrA(clrA),.clrB(clrB),.cnten(cnten),.ldcnt(ldcnt),
                .shenA(shenA),.cntenA(cntenA),.cntenB(cntenB),.inpRAMen(inpRAMen)
                                ,.sel(sel),.shenB(shenB),.enA(enA),.enB(enB),.outRAMen(outRAMen)
                                ,.ldshA(ldshA),.ldshB(ldshB),.check_sh(check_sh), .done(done),.ov(ov),.ov_cnt32(ov_cnt32));
    Controller ctrl (.start(start), .clk(clk),.rst(rst),.check_sh(check_sh),.ov_res(ov_cnt32) ,.OV(ov),
                .shenA(shenA),.shenB(shenB), .clr(clr),.clrA(clrA), .clrB(clrB),
                .cntEn(cnten),.ldshA(ldshA),.cntenA(cntenA),
                .ldshB(ldshB),.cntenB(cntenB),.ldcnt(ldcnt), .inpRamEn(inpRAMen), 
                .outRamEn(outRAMen), .sel(sel), .regEnA(enA), .regEnB(enB), .done(done));
        
endmodule