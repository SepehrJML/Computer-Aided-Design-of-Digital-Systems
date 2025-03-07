module shift_reg #(parameter N = 16)  (clk,rst,clr,in,ld,shen,out);
    input [N-1:0] in;
    input clk,rst,clr,shen,ld;
    output reg[N-1:0] out;

    always @(posedge clk,posedge rst)   begin
        if (rst | clr)
            out <= 0;
        else if (ld)
            out <= in;
	else if(shen)
            out <= {out[N-2:0],1'b0};
        
    end
endmodule