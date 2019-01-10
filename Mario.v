`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:31:17 12/22/2018 
// Design Name: 
// Module Name:    Mario 
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
module Mario(
	input clk, 
	input clk_walk_anim, 
	input clk_hero_anim, 
	input rstn, 
	input left, 
	input right, 
	input jump, 
	input level, // 0: normal 1: big
	input hero, // 0: no 1: yes
	output reg [5:0] id, 
	output reg oriental, // 0: right 1: left 
	output reg walk, // 0: no 1: yes
	output [10:0] w, 
	output [10:0] max_w, 
	output [10:0] h, 
	output [10:0] max_h
   );

	parameter hero_duration_times = 64;
	parameter splayer1l = 26;
	parameter splayer1r = 27;
	parameter splayer2l = 28;
	parameter splayer2r = 29;
	parameter splayer3l = 30;
	parameter splayer3r = 31;
	parameter player1l = 15;
	parameter player1r = 16;
	parameter player2l = 17;
	parameter player2r = 18;
	parameter player3l = 19;
	parameter player3r = 20;
	parameter null = 63;

	reg hero_state; // 0: hidden 1: show
	reg [1:0] walk_state; // 0/1/2
	reg walk_state_increase;

	wire [6:0] state;
	assign state[6:0] = {oriental, level, walk, hero, hero_state, walk_state};

	reg pre_walk_anim;
	reg pre_hero_anim;

	always@(posedge clk) begin
		if (~rstn) begin

			if (~oriental & left & ~right)
				oriental = 1;
			if (oriental & ~left & right)
				oriental = 0;
			walk = left | right;

			if (clk_walk_anim == 1 && pre_walk_anim == 0) begin
				if (walk && ~jump)
					if (walk_state_increase)
						case (walk_state)
							0: walk_state = 1;
							1: begin walk_state = 2; walk_state_increase = 0; end
						endcase
					else
						case (walk_state)
							2: walk_state = 1;
							1: begin walk_state = 0; walk_state_increase = 1; end
						endcase
			end

			if (clk_hero_anim == 1 && pre_hero_anim == 0) begin
				if (hero) begin
					hero_state = ~hero_state;
				end
			end
			
			pre_walk_anim = clk_walk_anim;
			pre_hero_anim = clk_hero_anim;

		end else begin
			oriental = 0;
			walk = 0;
			hero_state = 0;
			walk_state = 2'b0;
			walk_state_increase = 1;
			pre_walk_anim = clk_walk_anim;
			pre_hero_anim = clk_hero_anim;
		end

	end

	always@* begin
		if (state[3:2] == 2'b10) 
			id <= null;
		else case(state[6:4])
			3'b000: id <= splayer1r;
			3'b001: case(state[1:0])
				2'b00: id <= splayer1r;
				2'b01: id <= splayer2r;
				2'b10: id <= splayer3r;
				default: id <= 32;
			endcase
			
			3'b100: id <= splayer1l;
			3'b101: case(state[1:0])
				2'b00: id <= splayer1l;
				2'b01: id <= splayer2l;
				2'b10: id <= splayer3l;
				default: id <= 32;
			endcase
		
			3'b010: id <= player1r;
			3'b011: case(state[1:0])
				2'b00: id <= player1r;
				2'b01: id <= player2r;
				2'b10: id <= player3r;
				default: id <= 32;
			endcase
			
			3'b110: id <= player1l;
			3'b111: case(state[1:0])
				2'b00: id <= player1l;
				2'b01: id <= player2l;
				2'b10: id <= player3l;
				default: id <= 32;
			endcase
		
			default: id <= 32;
		endcase
	end
	
	assign max_w = level ? 11'd45 : 11'd40;
	assign max_h = level ? 11'd78 : 11'd42;

	Object object(
		.id(id), 
		.h(h), 
		.w(w)
	);

endmodule
