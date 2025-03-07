module rom #(parameter N=16,M=3) (input [M-1:0] addr,output signed[N-1:0] out_rom);
    reg [N-1:0] data [0:7];
    initial begin
	data[0] = 16'b0111111111111111;
        data[1] = 16'b1100000000000000;
        data[2] = 16'b0010101010101010;
        data[3] = 16'b1110000000000000;
        data[4] = 16'b0001100110011001;
        data[5] = 16'b1110101010101011;
        data[6] = 16'b0001001001001001;
        data[7] = 16'b1111000000000000;
    end

    assign out_rom = data[addr];
endmodule