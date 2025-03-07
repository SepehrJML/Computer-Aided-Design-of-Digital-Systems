module mul_addr #( parameter N = 4 ,M=2) (a,b,w);
    input [N-1 :0] a;
    input [M-1:0] b;
    output [N-1:0] w;
    reg [N+M-1:0] q;
    assign q = a*b;
    assign w = q[N-1:0];
endmodule