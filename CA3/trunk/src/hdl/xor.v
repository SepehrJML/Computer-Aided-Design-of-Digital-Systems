module custom_xor(input a,b,output w);
    c1 c(1'b0 , 1'b1 , b , 1'b1 , 1'b0 ,b , a , a,w);
endmodule