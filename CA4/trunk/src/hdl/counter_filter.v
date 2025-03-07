module counter_filter  #(parameter ADDR_WIDTH = 3,M=16) (clk,en,clr,in,pointer,ov);
	input clk,en,clr;
    input [M-1:0] in;
	output [ADDR_WIDTH-1:0] pointer;
	output ov;

	reg [ADDR_WIDTH-1:0] count=0;
	always @(posedge clk) begin
		if (clr)
			count <= 0;
		else if (en)
			count <= count + 1;
	end
	
	assign pointer = count;
    assign ov = (count == in);
endmodule
			