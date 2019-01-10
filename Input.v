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
	input clk, 
	input ps2_clk, 
	input ps2_data, 
	output reg left, right, jump, retry
    );

	wire [7:0] ps2_byte;
	wire ps2_state;

	reg [2:0] rst_ticks = 0;
	wire rst = &rst_ticks;

	PS2Driver PS2Driver(
		.clk(clk), 
		.rst(rst), 
		.ps2_clk(ps2_clk), // Input
		.ps2_data(ps2_data), // Input
		.ps2_byte(ps2_byte), // Output
		.ps2_state(ps2_state) // Output
	);

	always @(posedge clk) begin
		case (ps2_byte)
			8'h29: jump = ps2_state;
			8'h6b: left = ps2_state;
			8'h74: right = ps2_state;
			8'h2d: retry = ps2_state;
		endcase
		if (~&rst_ticks) rst_ticks = rst_ticks + 1'b1;
	end

endmodule
