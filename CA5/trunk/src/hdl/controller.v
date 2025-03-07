`define IDLE 3'b000
`define INIT 3'b001
`define STOP 3'b010
`define RUNNING 3'b011
module controller (input clk,start,empty,stall,ov0,ov1,ov2,ov,
                output reg clr,clrW,clr0,clr1,clr2,input [1:0] mode,input is_zero,output reg ctrl_en,en,en0,en1,en2,ld,en_all,done);
    reg [2:0] ps=0,ns=0;
    always @(posedge clk) 
        ps <= ns;
    always @(ps,start,empty,stall) begin
        case (ps)
            `IDLE: ns = (start) ? `INIT : `IDLE;
            `INIT: ns = (start) ?  `INIT : `STOP ;
            `STOP: ns = (empty | stall) ? `STOP : `RUNNING;
            `RUNNING: ns = (empty | stall) ? `STOP : `RUNNING;
        endcase
    end
    assign clr =  (ps == `INIT) ? 1'b1 :(empty | stall) ? 1'b0 :(ps == `RUNNING) ? (ov2&ov1) : 1'b0;
	assign clrW =  (ps == `INIT) ? 1'b1 : 1'b0;
    assign clr0 =(empty | stall) ? 1'b0 :(ps == `INIT) ? 1'b1 : (ov0 & (ps == `RUNNING)) ? 1'b1 : 1'b0;
    assign clr1 =(empty | stall) ? 1'b0 : (ps == `INIT) ? 1'b1 :(mode[0]&ov0&ov1&ov2  & (ps == `RUNNING)) ? 1'b1 :((~mode[0])&ov0&ov1  & (ps == `RUNNING))  ? 1'b1 : 1'b0;
    assign clr2 =(empty | stall) ? 1'b0 : (ps == `INIT) ? 1'b1 :((~mode[0])&ov0&ov1&ov2  & (ps == `RUNNING)) ? 1'b1 :(mode[0]&ov0&ov2  & (ps == `RUNNING))  ? 1'b1 : 1'b0;
    assign ctrl_en =( (ps == `STOP) | (ps == `RUNNING) ) ? 1'b1 : 1'b0;
    assign en = (empty | stall ) ? 1'b0 : (ps == `RUNNING) ? ~is_zero : 1'b0;
    assign en0 = (empty | stall) ? 1'b0 :(ps == `RUNNING) ? 1'b1 : 1'b0;
    assign en1 = (empty | stall) ? 1'b0 :((ps == `RUNNING)&(mode[0])) ? ov2&ov0 : ((ps == `RUNNING)&(~mode[0])) ? ov0  : 1'b0;
    assign en2 = (empty | stall) ? 1'b0 :((ps == `RUNNING)&(mode[0])) ? ov0 : ((ps == `RUNNING)&(~mode[0])) ? ov1&ov0  : 1'b0;
    assign ld = (empty | stall) ? 1'b0 :(ps == `RUNNING) ? (ov2&ov1&ov0) : 1'b0;
    assign done = ((ps == `RUNNING)| (ps == `STOP)) ? ov : 1'b0;
    assign en_all = ((stall)) ? 1'b1 :   1'b0;
    
endmodule