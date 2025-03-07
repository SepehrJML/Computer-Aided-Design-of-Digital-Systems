module counter_addr_psum #(parameter N=4) (input clk,acum,done,output reg [N-1:0] addr);
    initial addr=0;
    always @(posedge done) 
        if (~acum)
            addr <= addr + 1;
endmodule
