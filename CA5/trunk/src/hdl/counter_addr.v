module counter_ifmap  #(parameter ADDR_WIDTH = 3) (clk,en,clr,sig,pointer,ov);
	input clk,en,clr,sig;
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
    assign ov = sig;
endmodule
			