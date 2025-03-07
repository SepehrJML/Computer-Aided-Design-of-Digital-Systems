module rshift #(parameter N=16,NUM=15) (input signed [N+NUM-1:0] a,output signed [N-1:0] w);
    assign w = (a >> NUM);
endmodule