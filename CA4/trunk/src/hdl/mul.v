module mul #( parameter N = 16 ) (a,b,w);
    input signed [N-1 :0] a,b;
    output signed [2*N-2:0] w;
    assign w = a * b;
endmodule