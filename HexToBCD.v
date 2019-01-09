`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:49:16 01/09/2019 
// Design Name: 
// Module Name:    HexToBCD 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module HexToBCD(bin, bcd);


parameter BIN_BITS = 32;
parameter BCD_BITS = 40;


input wire [BIN_BITS - 1 : 0] bin;
output wire [BCD_BITS - 1 : 0] bcd;



localparam BCD_REAL_BITS = ((BIN_BITS-4)/3+1)*4 + (BIN_BITS-1)%3 + 1;



wire [BCD_REAL_BITS - 1 : 0] bcd_i;



wire [3:0] d[0 : (BCD_BITS - 1) / 4][0 : BIN_BITS - 4];
wire [3:0] c[0 : (BCD_BITS - 1) / 4][0 : BIN_BITS - 4];

genvar i, j;


generate
begin
if (BCD_BITS < BCD_REAL_BITS) 
begin
assign bcd[BCD_BITS-1 : 0] = bcd_i[BCD_BITS - 1 : 0]; 
end
else
begin
assign bcd[BCD_REAL_BITS - 1 : 0] = bcd_i[BCD_REAL_BITS - 1 : 0]; 
if (BCD_BITS > BCD_REAL_BITS)
assign bcd[(BCD_BITS - 1)- : BCD_BITS - BCD_REAL_BITS] = 0; 
end
end
endgenerate

generate
begin
for (i = 0; i < (BIN_BITS - 4) / 3 + 1; i = i + 1)
begin
for (j = i * 3; j < BIN_BITS - 3; j = j + 1)
begin
if (i == 0)
begin
if (j == 0)
assign d[0][j] = {1'b0, bin[(BIN_BITS - 1)-:3]};
else
assign d[0][j] = {c[0][j-1][2:0], bin[BIN_BITS-3-j]};
end
else if (j == i * 3)
assign d[i][j] = {1'b0, c[i-1][j-3][3], c[i-1][j-2][3], c[i-1][j-1][3]}; 
else
assign d[i][j] = {c[i][j-1][2:0], c[i-1][j-1][3]};

assign c[i][j] = add3_fun(d[i][j]);
end

if (i == 0)
assign bcd_i[((i+1)*4-1)-:4] = {c[i][BIN_BITS-4][2:0], bin[0]};
else
assign bcd_i[((i+1)*4-1)-:4] = {c[i][BIN_BITS-4][2:0], c[i-1][BIN_BITS-4][3]};
end

for(j = BCD_REAL_BITS % 4; j != 0; j = j - 1)
assign bcd_i[(BCD_REAL_BITS/4)*4+(j-1)] = c[BCD_REAL_BITS/4-1][BIN_BITS-4-(j-1)][3]; 
end
endgenerate


function automatic [3:0] add3_fun;
input [3:0] in;
begin
case (in)
4'b0000: add3_fun = 4'b0000;
4'b0001: add3_fun = 4'b0001;
4'b0010: add3_fun = 4'b0010;
4'b0011: add3_fun = 4'b0011;
4'b0100: add3_fun = 4'b0100;
4'b0101: add3_fun = 4'b1000;
4'b0110: add3_fun = 4'b1001;
4'b0111: add3_fun = 4'b1010;
4'b1000: add3_fun = 4'b1011;
4'b1001: add3_fun = 4'b1100;
default: add3_fun = 4'b0000;
endcase
end
endfunction


endmodule