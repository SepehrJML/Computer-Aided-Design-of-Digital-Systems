`define IDLE 4'b0000
`define READY_TO_WRITE 4'b0001
`define WRITE 4'b0010
`define WAIT 4'b0011
`define WAIT2 4'b0100
`define WAIT3 4'b0101
`define WAIT4 4'b0110
`define WAIT5 4'b0111
`define WAIT6 4'b1000
module output_write_controller(
    input clk, done, ready,clr_4,
    output reg w_en, stall
);
    reg[2:0] ps = `IDLE, ns = `IDLE;

    always @ (posedge clk) begin
        ps <= ns;
    end

    always @ (ps,done, ready) begin
        case (ps)
            `IDLE: ns = (done) ? `READY_TO_WRITE : `IDLE;
            `READY_TO_WRITE: ns = (ready) ?  `WRITE : `READY_TO_WRITE ;
            `WRITE: ns = `WAIT ;
		`WAIT: ns = (done) ? `WAIT : `IDLE;
		`WAIT2: ns = `WAIT3;
        `WAIT3: ns = `WAIT4;
        `WAIT4: ns = `WAIT5;
        `WAIT5: ns = `WAIT6;
        `WAIT6: ns = `IDLE;
        endcase
    end
	assign stall =(clr_4) ? 1'b0 :((ps == `IDLE) & done) ? 1'b1 : ((ps == `READY_TO_WRITE) | (ps == `WRITE)) ? 1'b1 : 1'b0;
    always @ (ps) begin
        {w_en} = 1'b0;
        case (ps)
            `READY_TO_WRITE: {w_en} = 1'b1;
        endcase
    end
endmodule