module check_empty #(parameter PAR_READ = 1, ADDR_WIDTH = 3) (
    input [ADDR_WIDTH-1:0] r_pnt, w_pnt,
    output reg empty
);

    integer i;
    reg flag=0;
    reg [ADDR_WIDTH-1:0] next_pnt;

   always @(*) begin
	flag=0;
	for ( i = 0; i < PAR_READ ; i = i + 1) begin
		next_pnt = r_pnt + i;
		if ( next_pnt == w_pnt)
			flag=1;
		end
	end
    assign empty = flag;
endmodule