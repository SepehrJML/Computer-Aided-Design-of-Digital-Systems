module counter #(parameter N = 4) (clk,rst,in,ld,clr,cnten,out,ov);
    input clk,rst,clr,cnten,ld;
    input [N-1:0] in;
    output reg [N-1:0] out;
    output ov;

    always @(posedge clk,posedge rst) begin
        if (rst) 
            out <= {N{1'b0}};
        else if (clr) 
            out <= {N{1'b0}}; 
        else if (ld)
	    out <= in;
	else if (cnten) 
            out <= out + 1; 
	
    end
    assign ov = out[N-1];
endmodule