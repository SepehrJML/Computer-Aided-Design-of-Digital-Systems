module FA(input a,b,ci,output y,co);
    wire out_c1;
    custom_xor c1(a,b,out_c1);
    custom_xor c2(out_c1,ci,y);
    c1 c3(1'b0 , ci , b , ci , 1'b1 ,b , a , a, co);
endmodule