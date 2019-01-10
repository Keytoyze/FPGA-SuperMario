`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:25:54 12/28/2018 
// Design Name: 
// Module Name:    Turtle 
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
module Turtle(
	input clk, 
	input clk_walk_anim, 
	input rstn, 
	input initial_show, 
	input collapsion_impulse, 
	input press_impulse, 
	output reg [5:0] id, 
	output reg oriental, // 0: right; 1: left
	output [10:0] w, 
	output [10:0] h, 
	output reg shell, 
	output reg shell_anim
   );
	
	parameter turtlel1 = 32;
	parameter turtlel2 = 33;
	parameter turtler1 = 34;
	parameter turtler2 = 35;
	parameter shell1 = 21;
	parameter shell2 = 22;
	parameter shell3 = 23;
	parameter shell4 = 24;
	parameter null = 63;

	reg walk_state; 
	reg pre_collapsion;
	reg pre_press; 
	reg pre_walk_anim;

	always@(posedge clk) begin
		if (~rstn) begin

			if (pre_collapsion != collapsion_impulse) begin
				pre_collapsion = collapsion_impulse;
				oriental = ~oriental;
			end
			
			if (pre_press != press_impulse) begin
				pre_press = press_impulse;
				if (shell) shell_anim = ~shell_anim;
				else begin
					shell = 1;
					shell_anim = 0;
				end
			end
			
			if (pre_walk_anim != clk_walk_anim) begin
				pre_walk_anim = clk_walk_anim;
				walk_state = ~walk_state;
			end

		end else begin
			walk_state = 1;
			oriental = 1;
			shell = 0;
			shell_anim = 0;
			pre_collapsion = collapsion_impulse;
			pre_press = press_impulse;
			pre_walk_anim = clk_walk_anim;
		end
	end

	always@* begin
		if (~initial_show)
			id <= null;
		else if (shell)
			id <= shell1;
		else case ({oriental, walk_state})
			2'b00: id <= turtlel1;
			2'b01: id <= turtlel2;
			2'b10: id <= turtler1;
			2'b11: id <= turtler2;
			default: id <= turtler1;
		endcase
	end

	Object object(
		.id(id), 
		.h(h), 
		.w(w)
	);


endmodule
