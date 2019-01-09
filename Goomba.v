`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:40:19 12/27/2018 
// Design Name: 
// Module Name:    Goomba 
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
module Goomba(
	input clk, 
	input rstn, 
	input initial_show, 
	input collapsion_impulse, 
	input press_impulse, 
	output reg [5:0] id, 
	output reg oriental, // 0: right; 1: left
	output [10:0] w, 
	output [10:0] h, 
	output reg live
   );

	parameter press_duration = 50000000;

	reg pre_collapsion;
	reg pre_press;
	reg [26:0] press_ticks; // [0, press_duration]
	reg showing;

	always@(posedge clk) begin
		if (~rstn) begin

			if (id == 12) begin
				press_ticks = press_ticks + 1'b1;
			end

			if (press_ticks >= press_duration) begin
				showing = 0;
			end

			if (pre_collapsion != collapsion_impulse) begin
				oriental = ~oriental;
			end
			
			if (pre_press != press_impulse) begin
				live = 0;
				press_ticks = 0;
			end

			pre_collapsion = collapsion_impulse;
			pre_press = press_impulse;

		end else begin
			press_ticks = 0;
			showing = initial_show;
			live = initial_show;
			oriental = 1;
			pre_collapsion = collapsion_impulse;
			pre_press = press_impulse;
		end
	end

	always@* begin
		if (~showing)
			id <= 63;
		else if (live)
			id <= 10;
		else
			id <= 12;
	end

	Object object(
		.id(id), 
		.h(h), 
		.w(w)
	);


endmodule
