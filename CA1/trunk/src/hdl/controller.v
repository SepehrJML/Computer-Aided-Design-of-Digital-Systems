// Define States
`define Idle     4'b0000
`define Init     4'b0001
`define InputRam 4'b0010
`define A        4'b0011
`define B        4'b0100
`define Calc     4'b0101
`define Done     4'b0110
`define AshiftCheck   4'b0111
`define BshiftCheck   4'b1000
`define readyRes 4'b1001
`define shiftResCheck 4'b1010
`define ovDetect 4'b1011
`define Ashift  4'b1100
`define Bshift  4'b1101
`define shiftRes 4'b1110

module Controller(start, clk,rst,check_sh ,ov_res,OV,shenA,shenB ,clr,clrA, clrB,cntEn,ldshA,cntenA,
                ldshB,cntenB,ldcnt, inpRamEn, outRamEn, sel, regEnA, regEnB, done);
    input start, clk,rst,check_sh,ov_res ,OV;
    output reg shenA,shenB,clr,clrA, clrB,cntEn,ldshA,cntenA,ldshB,cntenB,ldcnt, inpRamEn, outRamEn, sel, regEnA, regEnB, done;

	reg[3:0] ps = 4'b0000, ns = 4'b0000;
    
    always @(posedge clk, posedge rst) begin
	if (rst)
		ps <= `Idle;
	else
        	ps <= ns;
    end

    always @ (ps,start,check_sh,ov_res,OV) begin
        case (ps)
            `Idle: ns = (start) ? `Init : `Idle;
            `Init: ns = (start) ? `Init : `InputRam;
            `InputRam: ns = `A;
            `A: ns = `AshiftCheck;
            `AshiftCheck: ns = (check_sh) ? `B : `Ashift;
	    `Ashift: ns = `AshiftCheck;
            `B: ns = `BshiftCheck;  
            `BshiftCheck: ns = (check_sh) ? `readyRes : `Bshift;
		`Bshift: ns = `BshiftCheck;
            `readyRes: ns = `Calc;
            `Calc: ns = `shiftResCheck;
            `shiftResCheck: ns = (ov_res) ? `ovDetect : `shiftRes;
		`shiftRes: ns = `shiftResCheck;
            `ovDetect: ns = (OV) ? `Done : `InputRam;
            `Done: ns = `Idle;
        endcase
    end

    always @ (ps) begin
        {shenA,shenB,clr,clrA,clrB, cntEn,ldshA,cntenA,ldshB,cntenB,ldcnt, inpRamEn, outRamEn, sel, regEnA, regEnB, done} = 17'b0;

        case (ps)
            // `Idle: do nothing
            
            `Init: begin
                clr = 1'b1;
            end
            
            `InputRam: begin
                inpRamEn = 1'b1;
                clrA = 1'b1;
                clrB = 1'b1;
            end

            `A: begin
                ldshA = 1'b1;
                cntEn = 1'b1;
            end
            
            `Ashift: begin
                shenA = 1'b1;
                cntenA = 1'b1;
            end
            `B: begin
                sel = 1'b1;
                regEnA = 1'b1;
		        ldshA = 1'b1;
                clrB = 1'b1;
            end  
            `Bshift: begin
                shenA = 1'b1;
                cntenA = 1'b1;  
            end
            `readyRes: begin
                regEnB = 1'b1;
            end
            `Calc: begin
                ldshB = 1'b1;
                ldcnt = 1'b1;
            end
            `shiftRes: begin
                cntenB = 1'b1;
                shenB = 1'b1;
            end
            `ovDetect: begin
                outRamEn = 1'b1;
            end
            `Done: begin
                done = 1'b1;
            end


        endcase

    end

endmodule