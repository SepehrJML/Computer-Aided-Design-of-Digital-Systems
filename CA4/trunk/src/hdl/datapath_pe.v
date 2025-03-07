module datapath_pe #(parameter DATA_WIDTH=8,ADDR_WIDTH_IFM=4,ADDR_WIDTH_FIL=3,S=2,F=2,PAR_WRITE = 2,PAR_READ = 1,FIL_DEPTH=16) (input clk,en_all,r_en,ld,en0,en1,en2,clr,clrW,clr0,clr1,clr2,output clr_4,input en,w_en_ifm
    ,w_en_fil,done,ctrl_en,input [DATA_WIDTH*PAR_WRITE+1:0]data_in_ifm,input [DATA_WIDTH*PAR_WRITE-1:0] data_in_fil,input [S-1:0] stride,input[F-1:0] filter_size,output [DATA_WIDTH*PAR_READ-1:0] out,
    output valid,empty,stall,ready_ifm,ready_fil,ov0,ov1,ov2,ov0_3);
    wire [DATA_WIDTH+1:0] din_ifm,dout_ifm;
    wire[ADDR_WIDTH_IFM-1:0] waddr_ifm,out_reg_addr_ifm,raddr_ifm,raddr_ifm_empty;
    wire full_ifm,empty_ifm,wen_read_ctrl_ifm,r_en_buffer_ifm,valid_buffer_ifmap;
    wire [DATA_WIDTH-1:0] din_fil,dout_fil;
    wire[ADDR_WIDTH_FIL-1:0] waddr_fil,raddr_fil;
    wire full_fil,empty_fil,wen_read_ctrl_fil,r_en_buffer_fil,valid_buffer_filter;
    wire [ADDR_WIDTH_IFM-1:0] out_count_addr_ifm,out_mul_ifm,out_add_ifmap;
    wire [F-1:0] out_count_window;
    wire [ADDR_WIDTH_FIL-1:0] out_count_addr_fil,out_mul_fil;
    wire ready_out_buff;
    wire w_en_out_buff;
	wire clr_1,clr_2,clr_3,clr_5,clr_6;
    wire [3:0] clrs;
    assign clrs[0] = clr;
    genvar j;
    generate
	for (j = 0; j < $pow(2,F) - 1; j = j + 1) begin : gen_block
		register_addr #(1) reg_clr_6(clk,1,0,clrs[j],clrs[j+1]);
	end
    endgenerate
    register_addr #(1) reg_clr_1(clk,1,0,clrs[3],clr_1);
    register_addr #(1) reg_clr_2(clk,~en_all,0,clr_1,clr_2);
    register_addr #(1) reg_clr_3(clk,~en_all,0,clr_2,clr_3);
    register_addr #(1) reg_clr_4(clk,~en_all,0,clr_3,clr_4);
	wire en_1,en_2;
	register_addr #(1) reg_en_1(clk,~en_all,clr_3|clrW,en,en_1);
	register_addr #(1) reg_en_2(clk,~en_all,clr_4|clrW,en_1,en_2);
    fifo_buffer  #(DATA_WIDTH+2,ADDR_WIDTH_IFM,PAR_WRITE,1) fifo_buffer_ifmap (clk,w_en_ifm,r_en_buffer_ifm,data_in_ifm,ready_ifm,valid_buffer_ifmap,din_ifm);
    RSP #(DATA_WIDTH+2,ADDR_WIDTH_IFM, 1,1) regfile (clk,wen_read_ctrl_ifm,waddr_ifm,raddr_ifm,din_ifm,dout_ifm);
    check_full #(1,ADDR_WIDTH_IFM) full_cheker_ifm (out_reg_addr_ifm, waddr_ifm,full_ifm);
    check_empty #(1, ADDR_WIDTH_IFM) empty_cheker_ifm (raddr_ifm, waddr_ifm,empty_ifm);
    counter_buffer #(ADDR_WIDTH_IFM,1) w_cnt_ifmap (clk,wen_read_ctrl_ifm,clrW,waddr_ifm);
    input_read_controller read_ctrl_ifmap( clk, valid_buffer_ifmap, full_ifm,ctrl_en,  r_en_buffer_ifm, wen_read_ctrl_ifm);


    
    fifo_buffer  #(DATA_WIDTH,ADDR_WIDTH_FIL,PAR_WRITE,1) fifo_buffer_filter (clk,w_en_fil,r_en_buffer_fil,data_in_fil,ready_fil,valid_buffer_filter,din_fil);
    SSP #( DATA_WIDTH,ADDR_WIDTH_FIL,1,1) sram_fil(clk,wen_read_ctrl_fil,en,1'b1,waddr_fil,raddr_fil,din_fil,dout_fil);
    check_full #(1,ADDR_WIDTH_FIL) full_cheker_fil (0, waddr_fil,full_fil);
    check_empty #(1, ADDR_WIDTH_FIL) empty_cheker_fil (raddr_fil, waddr_fil,empty_fil);
    counter_buffer #(ADDR_WIDTH_FIL,1) w_cnt_filter (clk,wen_read_ctrl_fil,clrW,waddr_fil);
    input_read_controller read_ctrl_filter( clk, valid_buffer_filter, full_fil,ctrl_en,  r_en_buffer_fil, wen_read_ctrl_fil);

    register_addr #(ADDR_WIDTH_IFM) reg_ifm(clk,ld,clrW,raddr_ifm+1,out_reg_addr_ifm);//
    counter_ifmap  #(ADDR_WIDTH_IFM) counter_ifm(clk,en1,clr1,dout_ifm[DATA_WIDTH],out_count_addr_ifm,ov1);
    mul_addr #(ADDR_WIDTH_IFM,S) mul_ifm(out_count_addr_ifm,stride,out_mul_ifm);
    counter_filter  #(ADDR_WIDTH_IFM,F) counter_window (clk,en0,clr0,filter_size-1,out_count_window,ov0);
    adder #(ADDR_WIDTH_IFM) adder_ifmap (out_mul_ifm,{{(ADDR_WIDTH_IFM-F){1'b0}},out_count_window},out_add_ifmap);
    adder #(ADDR_WIDTH_IFM) add_with_reg (out_add_ifmap,out_reg_addr_ifm,raddr_ifm);
    integer i;
    always @(filter_size)
        i = FIL_DEPTH/filter_size;

    counter_filter  #(ADDR_WIDTH_FIL,32) count(clk,en2,clr2,i-1,out_count_addr_fil,ov2);
    mul_addr #(ADDR_WIDTH_FIL,F) mul_fil (out_count_addr_fil,filter_size,out_mul_fil);
    adder #(ADDR_WIDTH_FIL) adder_filter (out_mul_fil,{{(ADDR_WIDTH_FIL-F){1'b0}},out_count_window},raddr_fil);
    wire ov0_1,ov0_2;
    register_addr #(1) reg_ov_1(clk,en,clr_2|clrW,ov0,ov0_1);
    wire [DATA_WIDTH-1:0] data_ifmap_1;
    register_addr #(DATA_WIDTH) data_ifmap (clk,en,0|clrW,dout_ifm[DATA_WIDTH-1:0],data_ifmap_1);
    wire [2*DATA_WIDTH-2:0] out_mul_datas,in_add_data,out_add_datas,out_sum,in_add;
    mul #(DATA_WIDTH) mul_datas (data_ifmap_1,dout_fil,out_mul_datas);
    register_addr #(2*DATA_WIDTH) reg_mul (clk,(en_1&(~en_all)),0|clrW,out_mul_datas,in_add_data);
    register_addr #(1) reg_ov_2(clk,(en_1&(~en_all)),clr_3|clrW,ov0_1,ov0_2);
    adder #(2*DATA_WIDTH-1) add_data (in_add_data,in_add,out_add_datas);
    mux #(2*DATA_WIDTH-1) mux_add (ov0_3,out_sum,0,in_add);
    register_addr #(2*DATA_WIDTH-1) reg_add (clk,(en_2&(~en_all)),0|clrW,out_add_datas,out_sum);
    register_addr #(1) reg_ov_3(clk,(en_2&(~en_all)),clr_4|clrW,ov0_2,ov0_3);


    output_write_controller out_ctrl(clk, done, ready_out_buff,clr_4,w_en_out_buff,stall);
    fifo_buffer #(DATA_WIDTH,8,1,PAR_READ) fifo_out (clk,w_en_out_buff,r_en,out_sum[DATA_WIDTH-1:0],ready_out_buff,valid,out);
    assign empty = empty_fil | empty_ifm;

endmodule
