module reg_pipe #(parameter N=16) (input clk,clr,en,input [N-1:0] in,output reg [N-1:0] out);
    always @(posedge clk) begin
        if (clr) 
            out <= 0;
        else if (en)
            out <= in;
    end
endmodule