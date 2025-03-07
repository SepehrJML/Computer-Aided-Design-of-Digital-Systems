module right_shift #(parameter N = 16)  (clk,clr,in,shen,ld,out);
    input clk,clr,shen,ld;
    input [0:N-1] in;
    output [0:N-1] out;

    genvar i;
    generate
        for (i = 15; i > 0; i = i - 1) begin : s2_16
            s2 s2(out[i] , out[i-1] ,in[i] , 0 , ld , 0 , shen,1 , clr , clk , out[i]);
        end
    endgenerate
    s2 s1(out[0] , 0 ,in[0] , 0 , ld , 0 , shen,1 , clr , clk , out[0]);
endmodule