module downcounter #(parameter N = 5) (clk,in,ld,clr,cnten,out,ov);
    output [N-1:0] out;
    input [N-1:0] in;
    input clk,ld,clr,cnten;
    output ov;

    wire [N-1:0] out_half,carry,cin;
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : s2_16
            s2 s2(out_half[i] , in[i] ,0 , 0 , 0 , 0 , ld,ld , clr , clk , out[i]);
        end
    endgenerate
    genvar j;
    HA F0(out[0],cnten,out_half[0],carry[0]);
    generate
        for (j = 1; j < N; j = j + 1) begin : h_16
            FA F(out[j],cnten,carry[j-1],out_half[j],carry[j]);
        end
    endgenerate
    

    wire and_wire;
    c1 c0( 1 , 0 , out[2] , 0 , 0 ,0 , out[0] , out[1],and_wire) ;
    c1 c1( and_wire , 0 , 0 , 0 , 0 ,0 , out[3] , out[4],ov) ;
endmodule