`define IDLE 2'b00
`define VALID_OUTPUT 2'b01
`define UPDATE_OUTPUT 2'b10

module read_controller(
    input clk, r_en, empty,
    output reg valid, r_cnt
);
    reg[1:0] ps = `IDLE, ns = `IDLE;

    always @ (posedge clk) begin
        ps <= ns;
    end

    always @ (ps, r_en, empty) begin
        case (ps)
            `IDLE: ns = (~r_en | empty) ? `IDLE : `VALID_OUTPUT;
            `VALID_OUTPUT: ns = (r_en) ? `VALID_OUTPUT : `UPDATE_OUTPUT;
            `UPDATE_OUTPUT: ns = `IDLE;
        endcase
    end

    always @ (ps) begin
        {valid, r_cnt} = 2'b00;
        case (ps)
            `VALID_OUTPUT: valid = 1'b1;
            `UPDATE_OUTPUT: r_cnt = 1'b1; 
        endcase
    end
endmodule