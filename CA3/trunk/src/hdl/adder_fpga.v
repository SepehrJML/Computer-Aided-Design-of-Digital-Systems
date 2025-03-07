module adder_fpga #(parameter N = 4) (
    input [N-1:0] a,
    input [N-1:0] b,
    
    output [N:0] y
);
    wire [N-1:0] couts;

    HA a0 (a[0],b[0],y[0],couts[0]);

    genvar i;
    generate
        for (i = 1; i < N; i = i + 1) begin : generate_statement
            FA fa (a[i],b[i],couts[i-1],y[i],couts[i]);
        end
    endgenerate
	
    assign y[N] = couts[N-1];
endmodule