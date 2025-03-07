module register #(parameter N=32,K=16,M=3) (input clk,rst,rst_main,en,valid_flag_in,of_flag_in,
                        input[K-1:0] Xin,x_in,x_pow_in,input[N-1:0] y_in,input[M-1:0] addr_in,
                        output reg valid_flag_out,of_flag_out, output reg[K-1:0] x_out,x_pow_out,
                        output reg[N-1:0] y_out,output reg[M-1:0] addr_out);
    always @(posedge clk,posedge rst_main)   begin
        if (rst | rst_main)    begin
            addr_out <= 0;
            x_out <= Xin;
            x_pow_out <= 16'b0111111111111111;
            y_out <= 0;
            valid_flag_out <= 0;
            of_flag_out <= 0;
        end
        else if (en)    begin
            addr_out <= addr_in;
            x_out <= x_in;
            x_pow_out <= x_pow_in;
            y_out <= y_in;
            valid_flag_out <= valid_flag_in;
            of_flag_out <= of_flag_in;
        end
    end
endmodule