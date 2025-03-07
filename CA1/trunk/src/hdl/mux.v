module mux #(parameter N = 16) (sel,a,b,w);
    input sel;
    input [N-1:0] a,b;
    output [N-1:0] w;

    assign w = (sel) ? b : a;
endmodule