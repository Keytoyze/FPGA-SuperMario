`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:56:08 01/09/2019 
// Design Name: 
// Module Name:    DispBCD 
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
module DispBCD(
	input [31:0] clkdiv, 
	input [31:0] hex, 
	output [3:0] sout
   );

	wire [3:0] sout;
	wire [39:0] bcd;

   Seg7Device segDevice(.clkIO(clkdiv[3]), .clkScan(clkdiv[15:14]), .clkBlink(clkdiv[25]),
		.data(bcd[31:0]), .point(8'h0), .LES(8'h0),
		.sout(sout));
/*
	assign SEGLED_CLK = sout[3];
	assign SEGLED_DO = sout[2];
	assign SEGLED_PEN = sout[1];
	assign SEGLED_CLR = sout[0];*/

	HexToBCD #(.BIN_BITS(32), .BCD_BITS(40)) hexToBCD(
		.bin(hex), 
		.bcd(bcd)
	);

endmodule
