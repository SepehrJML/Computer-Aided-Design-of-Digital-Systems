module RSP #(parameter DATA_WIDTH = 16,ADDR_WIDTH = 3,PAR_WRITE = 2,PAR_READ = 1) (clk,wen,waddr,raddr,din,dout);
    input clk,wen;
    input [ADDR_WIDTH - 1 : 0] waddr,raddr;
    input [PAR_WRITE * DATA_WIDTH - 1 : 0] din;
    output reg[PAR_READ * DATA_WIDTH - 1 : 0] dout;

    reg [DATA_WIDTH - 1:0] ScratchPad [0:$pow(2, ADDR_WIDTH) - 1];
    initial begin
        ScratchPad[0] = 0;
    end
    integer i;
    genvar j;
    always @(posedge clk) begin
        if (wen) begin
            for (i = 0; i < PAR_WRITE ; i = i + 1)
                ScratchPad[waddr + i] = din[DATA_WIDTH*(i+1) - 1 -: DATA_WIDTH];
        end
    end
    generate
	for (j = 0; j < PAR_READ ; j = j + 1) begin : gen_block
		assign dout[DATA_WIDTH*(j+1) - 1 -: DATA_WIDTH] = ScratchPad[raddr + j];
	end
    endgenerate
endmodule