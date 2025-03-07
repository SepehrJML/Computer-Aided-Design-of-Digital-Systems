module counter_buffer  #(parameter ADDR_WIDTH = 3,PAR = 1) (clk,en,clr,pointer);
	input clk,en,clr;
	output [ADDR_WIDTH-1:0] pointer;
	
	reg [ADDR_WIDTH-1:0] count=0;
	always @(posedge clk) begin
		if (clr)
			count <= 0;
		else if (en)
			count <= count + PAR;
	end
	
	assign pointer = count;
endmodule
			