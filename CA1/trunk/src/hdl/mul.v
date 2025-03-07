module mul #( parameter N = 16 ) (a,b,w);
    input [N-1 :0] a,b;
    output [N-1:0] w;
    //reg whole_res [N+N-1:0];
    
    //assign whole_res = a * b;
    assign w = a[N-1:N/2] * b[N-1:N/2];
endmodule