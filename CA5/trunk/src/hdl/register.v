module register_addr #(parameter N = 4) (input clk,en,clr,input [N-1:0] in,output reg [N-1:0] out);
    always @(posedge clk) begin
        if (clr)
            out <= 0;
        else if (en)
            out <= in;
    end
endmodule