module register #(parameter N = 16, M = 3 ) (clk,rst,en,num_worthless_in,useful_in,num_worthless_out,useful_out);
    input clk,rst,en;
    input [M :0] num_worthless_in;
    input [N-1:0] useful_in;
    output reg [M :0] num_worthless_out;
    output reg [N-1:0] useful_out;

    always @(posedge clk,posedge rst) begin
        if (rst)
            {num_worthless_out,useful_out} <= 0;
        else if (en)
            {num_worthless_out,useful_out} <= {num_worthless_in,useful_in};
    end
endmodule