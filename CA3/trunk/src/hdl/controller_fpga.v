module controller_fpga (input clk,rst,start,check_ovA,check_ovB,Co0,Co,output clr,ld,ldA,enA,enB,enC,done);
    wire [0:4] states;
    wire not_start,not_Co0,not_state2,not_state3;
	custom_not a (start,not_start);
	custom_not b (Co0,not_Co0);
	custom_not d (states[2],not_state2);
	custom_not e (states[3],not_state3);
    s2 idle( 1'b0 , states[0] ,1'b1 , 1'b1 , rst , rst , not_start,not_start , 1'b0, clk , states[0]);
    s2 init(1'b0 , 1'b0 ,1'b0 , 1'b1,states[1],states[0],start,start,rst,clk , states[1] );
    s2 shift_in(1'b1 , 1'b1 ,1'b0 , 1'b1,not_state2,Co0,states[1],not_start,rst,clk , states[2] );
    s2 shift_out(1'b1 , 1'b1 ,1'b0 , 1'b1,not_state3,Co,Co0,states[2],rst,clk , states[3] );
    s2 finish( 1'b0 , 1'b1 ,1'b1 , 1'b1 , states[4], states[4] , states[3],Co , rst , clk , states[4]);

    c1 clrsig(1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,states[1],states[1],clr);
    c1 ldAsig(1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,states[1],states[1],ldA);
    c1 ldsig(1'b0,1'b0,1'b0,1'b0,1'b1,Co0,states[2],states[2],ld);
    c1 enAsig(1'b0,1'b0,1'b0,1'b1,1'b0,check_ovA,states[2],states[2],enA);
    c1 enBsig(1'b0,1'b0,1'b0,1'b1,1'b0,check_ovB,states[2],states[2],enB);
    c1 enCsig(1'b0,1'b0,1'b0,1'b1,1'b0,Co,states[3],states[3],enC);
    c1 donesig(1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,states[4],states[4],done);

endmodule