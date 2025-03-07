module lshift #(parameter N=32,NUM=1) (input signed [N-NUM-1:0] a,output signed [N-1:0] w);
    assign w = (a << NUM);
endmodule