`define Idle     3'b000
`define St    3'b001
`define StOut 3'b010
`define Init1 3'b011
`define Init2    3'b100    
`define Init3    3'b101  
`define Init4   3'b110  
`define Calc     3'b111


module controller (input clk,reset,start,valid_dp,ov_dp,output reg rstS1,rstS2,rstS3,rstS4,ready,valid,overflow,sel_initS1,sel_initS2,sel_initS3,sel_initS4);
    reg[2:0] ps = 3'b000, ns = 3'b000;
    
    always @(posedge clk) begin
        	ps <= ns;
    end

    always @ (ps,reset,start) begin
        case (ps)
            `Idle: ns = (reset) ? `St : `Idle;
            `St: ns = (start) ? `StOut : `St;
            `StOut: ns = (start) ? `StOut : `Init1;
            `Init1: ns = (reset) ? `St : `Init2;
            `Init2: ns = (reset) ? `St : `Init3;
	    `Init3: ns = (reset) ? `St : `Init4;
            `Init4: ns = (reset) ? `St  : `Calc;
            `Calc: ns = (reset) ? `St : `Calc;
        endcase
    end
	assign valid =( (ps == `Calc) ) ? ( valid_dp & (~ov_dp) )  : 1'b0;
	assign overflow=(  (ps == `Calc) ) ? ov_dp : 1'b0;
	assign ready= (ps == `Calc) ?  valid_dp :(  (ps == `Init1) |  (ps == `Init2) |  (ps == `Init3)|  (ps == `Init4) ) ? 1'b1 : 1'b0;
	assign rstS1 =(ps != `Calc) ? 1'b1 : valid_dp;
	assign {sel_initS1,sel_initS2,sel_initS3,sel_initS4,rstS2,rstS3,rstS4} = 7'b0;


endmodule

