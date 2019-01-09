`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:23:58 12/20/2018 
// Design Name: 
// Module Name:    Input 
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
module Input(
	input [2:0] btn, 
	input clk_1ms, 
	output K_ROW, 
	output left, 
	output right, 
	output jump
	//TODO: output reg hero
    );

	pbdebounce m1(.clk_1ms(clk_1ms), .button(~btn[0]), .pbreg(jump));
	pbdebounce m2(.clk_1ms(clk_1ms), .button(~btn[1]), .pbreg(left));
	pbdebounce m3(.clk_1ms(clk_1ms), .button(~btn[2]), .pbreg(right));
	
	assign K_ROW = 1'b0;

endmodule
