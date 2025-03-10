module mul_fpga(input [7:0] a,b,output [15:0] w);
    wire [63:0] and_outs;
    custom_and x0y0 (a[0],b[0],and_outs[0]);
    custom_and x0y1 (a[0],b[1],and_outs[1]);
    custom_and x0y2 (a[0],b[2],and_outs[2]);
    custom_and x0y3 (a[0],b[3],and_outs[3]);
    custom_and x0y4 (a[0],b[4],and_outs[4]);
    custom_and x0y5 (a[0],b[5],and_outs[5]);
    custom_and x0y6 (a[0],b[6],and_outs[6]);
    custom_and x0y7 (a[0],b[7],and_outs[7]);
    custom_and x1y0 (a[1],b[0],and_outs[8]);
    custom_and x1y1 (a[1],b[1],and_outs[9]);
    custom_and x1y2 (a[1],b[2],and_outs[10]);
    custom_and x1y3 (a[1],b[3],and_outs[11]);
    custom_and x1y4 (a[1],b[4],and_outs[12]);
    custom_and x1y5 (a[1],b[5],and_outs[13]);
    custom_and x1y6 (a[1],b[6],and_outs[14]);
    custom_and x1y7 (a[1],b[7],and_outs[15]);
    custom_and x2y0 (a[2],b[0],and_outs[16]);
    custom_and x2y1 (a[2],b[1],and_outs[17]);
    custom_and x2y2 (a[2],b[2],and_outs[18]);
    custom_and x2y3 (a[2],b[3],and_outs[19]);
    custom_and x2y4 (a[2],b[4],and_outs[20]);
    custom_and x2y5 (a[2],b[5],and_outs[21]);
    custom_and x2y6 (a[2],b[6],and_outs[22]);
    custom_and x2y7 (a[2],b[7],and_outs[23]);
    custom_and x3y0 (a[3],b[0],and_outs[24]);
    custom_and x3y1 (a[3],b[1],and_outs[25]);
    custom_and x3y2 (a[3],b[2],and_outs[26]);
    custom_and x3y3 (a[3],b[3],and_outs[27]);
    custom_and x3y4 (a[3],b[4],and_outs[28]);
    custom_and x3y5 (a[3],b[5],and_outs[29]);
    custom_and x3y6 (a[3],b[6],and_outs[30]);
    custom_and x3y7 (a[3],b[7],and_outs[31]);
    custom_and x4y0 (a[4],b[0],and_outs[32]);
    custom_and x4y1 (a[4],b[1],and_outs[33]);
    custom_and x4y2 (a[4],b[2],and_outs[34]);
    custom_and x4y3 (a[4],b[3],and_outs[35]);
    custom_and x4y4 (a[4],b[4],and_outs[36]);
    custom_and x4y5 (a[4],b[5],and_outs[37]);
    custom_and x4y6 (a[4],b[6],and_outs[38]);
    custom_and x4y7 (a[4],b[7],and_outs[39]);
    custom_and x5y0 (a[5],b[0],and_outs[40]);
    custom_and x5y1 (a[5],b[1],and_outs[41]);
    custom_and x5y2 (a[5],b[2],and_outs[42]);
    custom_and x5y3 (a[5],b[3],and_outs[43]);
    custom_and x5y4 (a[5],b[4],and_outs[44]);
    custom_and x5y5 (a[5],b[5],and_outs[45]);
    custom_and x5y6 (a[5],b[6],and_outs[46]);
    custom_and x5y7 (a[5],b[7],and_outs[47]);
    custom_and x6y0 (a[6],b[0],and_outs[48]);
    custom_and x6y1 (a[6],b[1],and_outs[49]);
    custom_and x6y2 (a[6],b[2],and_outs[50]);
    custom_and x6y3 (a[6],b[3],and_outs[51]);
    custom_and x6y4 (a[6],b[4],and_outs[52]);
    custom_and x6y5 (a[6],b[5],and_outs[53]);
    custom_and x6y6 (a[6],b[6],and_outs[54]);
    custom_and x6y7 (a[6],b[7],and_outs[55]);
    custom_and x7y0 (a[7],b[0],and_outs[56]);
    custom_and x7y1 (a[7],b[1],and_outs[57]);
    custom_and x7y2 (a[7],b[2],and_outs[58]);
    custom_and x7y3 (a[7],b[3],and_outs[59]);
    custom_and x7y4 (a[7],b[4],and_outs[60]);
    custom_and x7y5 (a[7],b[5],and_outs[61]);
    custom_and x7y6 (a[7],b[6],and_outs[62]);
    custom_and x7y7 (a[7],b[7],and_outs[63]);
    wire [55:0] carry_outs;
    wire [55:0] sums;
    HA h11 (and_outs[1],and_outs[8],carry_outs[0],sums[0]);
    FA h12 (and_outs[2],and_outs[9],carry_outs[0],sums[1],carry_outs[1]);
    FA h13 (and_outs[3],and_outs[10],carry_outs[1],sums[2],carry_outs[2]);
    FA h14 (and_outs[4],and_outs[11],carry_outs[2],sums[3],carry_outs[3]);
    FA h15 (and_outs[5],and_outs[12],carry_outs[3],sums[4],carry_outs[4]);
    FA h16 (and_outs[6],and_outs[13],carry_outs[4],sums[5],carry_outs[5]);
    FA h17 (and_outs[7],and_outs[14],carry_outs[5],sums[6],carry_outs[6]);
    HA h18 (carry_outs[6],and_outs[15],sums[7],carry_outs[7]);
    
    HA h21 (and_outs[16],sums[1],sums[8],carry_outs[8]);
    FA h22 (and_outs[17],sums[2],carry_outs[8],sums[9],carry_outs[9]);
    FA h23 (and_outs[18],sums[3],carry_outs[9],sums[10],carry_outs[10]);
    FA h24 (and_outs[19],sums[4],carry_outs[10],sums[11],carry_outs[11]);
    FA h25 (and_outs[20],sums[5],carry_outs[11],sums[12],carry_outs[12]);
    FA h26 (and_outs[21],sums[6],carry_outs[12],sums[13],carry_outs[13]);
    FA h27 (and_outs[22],sums[7],carry_outs[13],sums[14],carry_outs[14]);
    FA h28 (and_outs[23],carry_outs[7],carry_outs[14],sums[15],carry_outs[15]);

    HA h31 (and_outs[24],sums[9],sums[16],carry_outs[16]);
    FA h32 (and_outs[25],sums[10],carry_outs[16],sums[17],carry_outs[17]);
    FA h33 (and_outs[26],sums[11],carry_outs[17],sums[18],carry_outs[18]);
    FA h34 (and_outs[27],sums[12],carry_outs[18],sums[19],carry_outs[19]);
    FA h35 (and_outs[28],sums[13],carry_outs[19],sums[20],carry_outs[20]);
    FA h36 (and_outs[29],sums[14],carry_outs[20],sums[21],carry_outs[21]);
    FA h37 (and_outs[30],sums[15],carry_outs[21],sums[22],carry_outs[22]);
    FA h38 (and_outs[31],carry_outs[15],carry_outs[22],sums[23],carry_outs[23]);

    HA h41 (and_outs[32],sums[17],sums[24],carry_outs[24]);
    FA h42 (and_outs[33],sums[18],carry_outs[24],sums[25],carry_outs[25]);
    FA h43 (and_outs[34],sums[19],carry_outs[25],sums[26],carry_outs[26]);
    FA h44 (and_outs[35],sums[20],carry_outs[26],sums[27],carry_outs[27]);
    FA h45 (and_outs[36],sums[21],carry_outs[27],sums[28],carry_outs[28]);
    FA h46 (and_outs[37],sums[22],carry_outs[28],sums[29],carry_outs[29]);
    FA h47 (and_outs[38],sums[23],carry_outs[29],sums[30],carry_outs[30]);
    FA h48 (and_outs[39],carry_outs[23],carry_outs[30],sums[31],carry_outs[31]);
    
    HA h51 (and_outs[40],sums[25],sums[32],carry_outs[32]);
    FA h52 (and_outs[41],sums[26],carry_outs[32],sums[33],carry_outs[33]);
    FA h53 (and_outs[42],sums[27],carry_outs[33],sums[34],carry_outs[34]);
    FA h54 (and_outs[43],sums[28],carry_outs[34],sums[35],carry_outs[35]);
    FA h55 (and_outs[44],sums[29],carry_outs[35],sums[36],carry_outs[36]);
    FA h56 (and_outs[45],sums[30],carry_outs[36],sums[37],carry_outs[37]);
    FA h57 (and_outs[46],sums[31],carry_outs[37],sums[38],carry_outs[38]);
    FA h58 (and_outs[47],carry_outs[31],carry_outs[38],sums[39],carry_outs[39]);

    HA h61 (and_outs[48],sums[33],sums[40],carry_outs[40]);
    FA h62 (and_outs[49],sums[34],carry_outs[40],sums[41],carry_outs[41]);
    FA h63 (and_outs[50],sums[35],carry_outs[41],sums[42],carry_outs[42]);
    FA h64 (and_outs[51],sums[36],carry_outs[42],sums[43],carry_outs[43]);
    FA h65 (and_outs[52],sums[37],carry_outs[43],sums[44],carry_outs[44]);
    FA h66 (and_outs[53],sums[38],carry_outs[44],sums[45],carry_outs[45]);
    FA h67 (and_outs[54],sums[39],carry_outs[45],sums[46],carry_outs[46]);
    FA h68 (and_outs[55],carry_outs[39],carry_outs[46],sums[47],carry_outs[47]);

    HA h71 (and_outs[56],sums[41],sums[48],carry_outs[48]);
    FA h72 (and_outs[57],sums[42],carry_outs[48],sums[49],carry_outs[49]);
    FA h73 (and_outs[58],sums[43],carry_outs[49],sums[50],carry_outs[50]);
    FA h74 (and_outs[59],sums[44],carry_outs[50],sums[51],carry_outs[51]);
    FA h75 (and_outs[60],sums[45],carry_outs[51],sums[52],carry_outs[52]);
    FA h76 (and_outs[61],sums[46],carry_outs[52],sums[53],carry_outs[53]);
    FA h77 (and_outs[62],sums[47],carry_outs[53],sums[54],carry_outs[54]);
    FA h78 (and_outs[63],carry_outs[47],carry_outs[54],sums[55],carry_outs[55]);
    
    assign w[0] = and_outs[0];
    assign w[1] = sums[0];
    assign w[2] = sums[8];
    assign w[3] = sums[16];
    assign w[4] = sums[24];
    assign w[5] = sums[32];
    assign w[6] = sums[40];
    assign w[7] = sums[48];
    assign w[8] = sums[49];
    assign w[9] = sums[50];
    assign w[10] = sums[51];
    assign w[11] = sums[52];
    assign w[12] = sums[53];
    assign w[13] = sums[54];
    assign w[14] = sums[55];
    assign w[15] = carry_outs[55];
endmodule