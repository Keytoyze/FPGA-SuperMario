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
	//input [2:0] btn, 
	input clk, 
	input ps2_clk, 
	input ps2_data, 
	output reg left, 
	output reg right, 
	output reg jump
    );

	// pbdebounce m1(.clk_1ms(clk_1ms), .button(~btn[0]), .pbreg(jump));
	// pbdebounce m2(.clk_1ms(clk_1ms), .button(~btn[1]), .pbreg(left));
	// pbdebounce m3(.clk_1ms(clk_1ms), .button(~btn[2]), .pbreg(right));
	
	// assign K_ROW = 1'b0;

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
			//8'he0: begin
				//left = 1'b0; right = 1'b0;
			//end
		endcase
		if (~&rst_ticks) rst_ticks = rst_ticks + 1'b1;
	end

endmodule
