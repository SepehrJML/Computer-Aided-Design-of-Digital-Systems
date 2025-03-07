module counter  #(parameter ADDR_WIDTH = 3,PAR = 1) (clk,en,pointer);
	input clk,en;
	output [ADDR_WIDTH-1:0] pointer;
	
	reg [ADDR_WIDTH-1:0] count=0;
	always @(posedge clk) begin
		if (en)
			count <= count + PAR;
	end
	
	assign pointer = count;
endmodule
			