`timescale 1ns/1ns
module TB();
    reg clk=0,rst=0,start=0;
    wire done;
    top_module inst(clk,rst,start,done);
    always #50 clk=~clk;
    initial begin
        #125 start=1;
        #200 start=0;
        #100000 $stop;
    end
endmodule