`timescale 1ps/1ps
`default_nettype none

`define HALF_CLK 5
`define CLK (2 * `HALF_CLK)

module TB ();
    reg clk, rst, start;

    parameter OUTPUT_WIDTH = 32;

    reg [7 : 0] X;
    reg [2 : 0] N;

    integer valid_cnt = 0;

    wire [OUTPUT_WIDTH - 1 : 0] Y;
    wire valid, ready, overflow,error;
    reg [OUTPUT_WIDTH : 0] outputs [0 : 5 * 20 - 1];
    always @(clk)begin
        # `HALF_CLK
        clk <= ~clk;
    end

    integer j;
    integer true_;
    reg[31:0] ans,ans0,ano;
    always @(posedge clk) begin
        if (valid) begin
            //remove this if not necessary
            valid_cnt = valid_cnt + 1;
            if (valid_cnt >= 1 ? ready : 1) begin
                ano = (Y - outputs[j][OUTPUT_WIDTH - 1:0]);
                ans = ano[31] ? ~ano + 1 : ano;
                // ans = ans0 / 2**31;
                if ( ans < 32'b00001100000000000000000000000000 &
                    overflow == outputs[j][OUTPUT_WIDTH])
                    true_ = true_ + 1;

                j++;
            end
        end
    end

    integer ov = 0;
    always @(posedge clk) begin
        if (overflow)
            ov++;
    end

    ln test(clk,rst,start,X,N,Y,ready,valid,overflow,error);

    reg [7 : 0] inputs [0 : 19];
    reg [2 : 0] N_in [0 : 4];
    integer i, n;
    initial begin
        $readmemh("file/inputs.txt", inputs);
        $readmemh("file/outputs.mem", outputs);
        N_in = {3'd2, 3'd3, 3'd4, 3'd5, 3'd7};
        n = 0;
        true_ = 0;
        j = 0;

        ///////////////////////
        clk = 0;
        start = 0;
        rst = 0;
        #`CLK;
        rst = 1;
        #`CLK;
        rst = 0;
        #`CLK;

        while (n < 5) begin
            i = 0;
            start = 1;
            #`CLK;
            start = 0;
            N = N_in[n] - 1;
            #`CLK;
            while (i < 20) begin
                while (!ready) #`CLK;

                X = inputs[i];
                i++;
                #`CLK;
            end
            repeat (N < 4 ? 4 : 8) #`CLK;
            rst = 1;
            #`CLK;
            rst = 0;
            #`CLK;
            n++;
        end
        #`CLK;
        #`CLK $stop;

    end
endmodule


