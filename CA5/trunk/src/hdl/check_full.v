module check_full #(parameter PAR_WRITE = 2, ADDR_WIDTH = 3) (
    input [ADDR_WIDTH-1:0] r_pnt, w_pnt,
    output reg full
);
    reg [ADDR_WIDTH-1:0] next_pnt;
    reg flag=0;
    integer i;

    always @(*) begin
	flag=0;
	for ( i = 0; i < PAR_WRITE ; i = i + 1) begin
		next_pnt = w_pnt + i + 1;
		if ( r_pnt == next_pnt)
			flag=1;
	end
	end
    assign full = flag;
endmodule