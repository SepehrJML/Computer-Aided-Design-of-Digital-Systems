`define IDLE 2'b00
`define READY_TO_READ 2'b01
`define READ 2'b10

module input_read_controller(
    input clk, valid, full,ctrl_en,
    output reg r_en, wen
);
    reg[1:0] ps = `IDLE, ns = `IDLE;

    always @ (posedge clk) begin
        ps <= ns;
    end

    always @ (ps, valid, full,ctrl_en) begin
        case (ps)
            `IDLE: ns = (~ctrl_en | full) ? `IDLE : `READY_TO_READ;
            `READY_TO_READ: ns = (valid) ?  `READ : `READY_TO_READ ;
            `READ: ns = `IDLE ;
        endcase
    end

    always @ (ps) begin
        {r_en, wen} = 2'b00;
        case (ps)
            `READY_TO_READ: r_en = 1'b1;
            `READ: wen = 1'b1; 
        endcase
    end
endmodule