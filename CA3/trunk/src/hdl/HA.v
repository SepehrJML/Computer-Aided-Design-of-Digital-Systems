module HA(input a,b,output y,co);
    custom_xor c (a,b,y);
    custom_and w (a,b,co);
endmodule