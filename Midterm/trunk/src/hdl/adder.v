module adder #(parameter N = 32) (a,b,w,cout);
    input signed[N-1:0] a,b;
    output signed[N-1:0] w;
    output cout;
    assign w = a + b;
    assign cout =( (a[N-1] & b[N-1] & ~(w[N-1])) | ((~a[N-1]) & (~b[N-1]) & w[N-1]) );
endmodule