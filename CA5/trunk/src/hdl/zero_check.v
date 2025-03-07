module zero_checker #(parameter N=16) (input [N-1:0] in,input ov0,output is_zero);
    assign is_zero = (in == 0) ? ~ov0 : 1'b0;
endmodule