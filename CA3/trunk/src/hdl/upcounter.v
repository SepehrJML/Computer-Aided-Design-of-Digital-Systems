module upcounter #(parameter N = 4) (clk,clr,cnten,out,ov);
    input clk,clr,cnten;
    output [N-1:0] out;
    output ov;
    wire [N-1:0] out_half,carry;
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : s2_16
            s2 s2(out_half[i] , 1'b0 ,1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0,1'b0 , clr , clk , out[i]);
        end
    endgenerate
    genvar j;
    HA H0(out[0],cnten,out_half[0],carry[0]);
    generate
        for (j = 1; j < N; j = j + 1) begin : H2_16
            HA H(out[j],carry[j-1],out_half[j],carry[j]);
        end
    endgenerate
    
    assign ov = out[N-1];
endmodule