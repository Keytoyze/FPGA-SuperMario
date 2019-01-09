`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:51:19 01/06/2019 
// Design Name: 
// Module Name:    Coin 
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
module Coin(
    input clk, 
	input clk_flash_anim, 
	input rstn, 
	output reg [5:0] id
    );
	
	parameter coin1 = 4;
	parameter coin2 = 5;
	parameter coin3 = 6;
    parameter coin4 = 7;
	parameter null = 63;

	reg [1:0] shape_state;
	reg pre_collapsion;
	reg pre_flash_anim;

	always@(posedge clk) begin
		if (~rstn) begin
			
			if (pre_flash_anim != clk_flash_anim) begin
				shape_state = shape_state + 1;
			end
			
         pre_flash_anim = clk_flash_anim;

		end else begin
			shape_state = 2'b0;
            pre_flash_anim = clk_flash_anim;
		end
	end

	always@* begin
        case (shape_state)
			2'b00: id <= coin1;
			2'b01: id <= coin2;
			2'b10: id <= coin3;
			default: id <= coin4;
		endcase
	end

endmodule
