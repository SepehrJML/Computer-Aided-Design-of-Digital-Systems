module output_ram #(parameter N = 16 , M =  8, K = 3) (clk,rst,clr,done,addr,result,outRAMen);
    input clk,rst,clr,done,outRAMen;
    input [2*N-1:0] result;
    input [K:0] addr;
	
    reg [2*N-1:0] memory_output [0:M-1];
    integer file;
    always @(posedge clk,posedge rst) begin
        if (clr) 
		file = $fopen("file/data_output.txt", "w");
	else if (outRAMen) begin
            memory_output[ addr - 1] <= result;
     	    $fwrite(file, "%h\n", result);
	end
	else if (done)
		$fclose(file);
    end

endmodule