module iput_ram #(parameter N = 16 , K = 3)(clk,rst,inpRAMen,addr,a,b);
    input clk, rst, inpRAMen;
    input [K:0] addr;
    output reg [N-1:0] a, b;

    reg [N-1:0] memory_input [0:N-1];
    initial $readmemb("file/data_input.txt", memory_input);
    always @(posedge clk,posedge rst) begin
        if (rst)
            {a,b} <= 0;
        else if (inpRAMen)
            {a,b} <= {memory_input[{addr[K-1:0], 1'b0}] , memory_input[{addr[K-1:0], 1'b1}]};
    end
endmodule