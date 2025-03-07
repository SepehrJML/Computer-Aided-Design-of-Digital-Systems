`define IDLE 2'b00
`define READY_TO_WRITE 2'b01
`define WRITE 2'b10

module write_controller(
    input clk, w_en, full,
    output reg ready, buff_w
);
    reg[1:0] ps = `IDLE, ns = `IDLE;

    always @ (posedge clk) begin
        ps <= ns;
    end

    always @ (ps, w_en, full) begin
        case (ps)
            `IDLE: ns = (~w_en | full) ? `IDLE : `READY_TO_WRITE;
            `READY_TO_WRITE: ns = (w_en) ? `READY_TO_WRITE : `WRITE;
            `WRITE: ns = `IDLE;
        endcase
    end

    always @ (ps) begin
        {ready, buff_w} = 2'b00;
        case (ps)
            `READY_TO_WRITE: ready = 1'b1;
            `WRITE: buff_w = 1'b1; 
        endcase
    end
endmodule