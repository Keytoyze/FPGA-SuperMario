`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:02:38 12/23/2018 
// Design Name: 
// Module Name:    World 
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
module World(
	input [31:0] clkdiv, 
	input rstn, 
	input jump, 
	input left, 
	input right, 
	input [8:0] row_addr, // pixel ram row address, 480 (512) lines
	input [9:0] col_addr, // pixel ram col address, 640 (1024) pixels
	output reg [5:0] type, // 63 represents background color
	output reg [10:0] h, // relative height in the object. valid when type != 63
	output reg [10:0] w,  // relative width in the object. valid when type != 63
	output reg [1:0] over,  // 0x: sceen; 10: gameover; 11: win
	output [9:0] cx, 
	output [8:0] cy, 
	output reg [31:0] score
	);
	localparam L = 13; // Length of coordinator
	localparam N1 = 16; // Length of the max number of coin
	localparam N2 = 64; // Length of the max number of box
	localparam N3 = 8; // Length of the maxnumber of goomba, turtle and pipe.
	localparam ID = 6; // Length of the ID
	localparam W = 11; // Length of the width of the object
	// Common data
	wire clk_walk_anim = clkdiv[22]; // 0.17s 22
	wire clk_hero_anim = clkdiv[21]; // 0.08s 21
	wire clk_walk_turtle_anim = clkdiv[23]; // 0.34s 23
	wire [L-1:0] view_x;
	reg pause;
	// Initial data
	wire [L-1:0] map_width; 
	wire [L-1:0] castle_x; 
	wire [L-1:0] castle_y; 
	// Mario
	wire [L-1:0] init_mario_x; 
	wire [L-1:0] init_mario_y; 
	reg [12:0] mario_x;
	reg [12:0] mario_y;
	reg level; // 0: normal 1: big
	reg hero; // 0: no 1: yes
	reg [8:0] hero_ticks;
	reg [1:0] jump_state; // 00: reset; 10: up; 11: down
	reg [6:0] jump_ticks; // 127: up -> down
	wire [ID-1:0] mario_id;
	wire [W-1:0] mario_w;
	wire [W-1:0] mario_h;
	wire mario_oriental; 
	wire mario_walk;
	wire [W-1:0] mario_mw, mario_mh;
	Mario mario(.clk(clkdiv[0] & ~pause), 
		.clk_walk_anim(clk_walk_anim), .clk_hero_anim(clk_hero_anim), 
		.rstn(rstn), .left(left), .right(right), .jump(jump), 
		.level(level), .hero(hero), 
		.id(mario_id), .w(mario_w), .h(mario_h), .oriental(mario_oriental), .walk(mario_walk), 
		.max_w(mario_mw), .max_h(mario_mh));
	// Goomba
	reg [L-1:0] g_x [N3-1:0]; 
	reg [L-1:0] g_y [N3-1:0]; 
	wire [L*N3-1:0] init_goomba_x; // disable when {x, y} = 00
	wire [L*N3-1:0] init_goomba_y; 
	wire [L-1:0] g_init_x [N3-1:0];
	wire [L-1:0] g_init_y [N3-1:0];
	wire g_init_show [N3-1:0]; 
	reg g_collapsion [N3-1:0]; 
	reg g_press [N3-1:0];
	wire [ID-1:0] g_id [N3-1:0]; 
	wire [W-1:0] g_w [N3-1:0]; 
	wire [W-1:0] g_h [N3-1:0]; 
	wire g_live [N3-1:0];
	wire g_oriental [N3-1:0];
	genvar i;
	generate for (i = 0; i < N3; i = i + 1) begin: goombas
		assign g_init_x[i] = init_goomba_x[(i+1)*L-1:i*L];
		assign g_init_y[i] = init_goomba_y[(i+1)*L-1:i*L];
		assign g_init_show[i] = ~(~(| g_init_x[i]) & ~(| g_init_y[i]));
		Goomba goomba(
			.clk(clkdiv[0]), .rstn(rstn), .initial_show(g_init_show[i]), .collapsion_impulse(g_collapsion[i]), 
			.press_impulse(g_press[i]), .id(g_id[i]), .w(g_w[i]), .h(g_h[i]), .live(g_live[i]), .oriental(g_oriental[i]));
		end
	endgenerate
	// Turtle
	genvar i2;
	reg [L-1:0] t_x [N3-1:0]; 
	reg [L-1:0] t_y [N3-1:0]; 
	wire [L*N3-1:0] init_turtle_x; 
	wire [L*N3-1:0] init_turtle_y; 
	wire [L-1:0] t_init_x [N3-1:0];
	wire [L-1:0] t_init_y [N3-1:0];
	wire t_init_show [N3-1:0]; 
	reg t_collapsion [N3-1:0]; 
	reg t_press [N3-1:0];
	wire [ID-1:0] t_id [N3-1:0]; 
	wire [W-1:0] t_w [N3-1:0]; 
	wire [W-1:0] t_h [N3-1:0]; 
	wire t_shell [N3-1:0];
	wire t_shell_anim [N3-1:0];
	wire t_oriental [N3-1:0];
	generate for (i2 = 0; i2 < N3; i2 = i2 + 1) begin: turtles
		assign t_init_x[i2] = init_turtle_x[(i2+1)*L-1:i2*L];
		assign t_init_y[i2] = init_turtle_y[(i2+1)*L-1:i2*L];
		assign t_init_show[i2] = ~(~(| t_init_x[i2]) & ~(| t_init_y[i2]));
		Turtle turtle(
			.clk(clkdiv[0] & ~pause), .rstn(rstn), .clk_walk_anim(clk_walk_turtle_anim), 
			.initial_show(t_init_show[i2]), .collapsion_impulse(t_collapsion[i2]), 
			.press_impulse(t_press[i2]), .id(t_id[i2]), .w(t_w[i2]), .h(t_h[i2]), .shell(t_shell[i2]), 
			.oriental(t_oriental[i2]), .shell_anim(t_shell_anim[i2]));
		end
	endgenerate
	// Box
	genvar i3;
	wire [L*N2-1:0] init_box_x; 
	wire [L*N2-1:0] init_box_y; 
	wire [2*N2-1:0] init_box_state; // 0: coin, 1: pilz, 2: box, 3: stone
	wire [1:0] b_init_state [N2-1:0];
	wire [L-1:0] b_x [N2-1:0]; 
	wire [L-1:0] b_y [N2-1:0]; 
	wire [L-1:0] b_en [N2-1:0];
	reg [1:0] b_state [N2-1:0];
	generate for (i3 = 0; i3 < N2; i3 = i3 + 1) begin: boxs
		assign b_x[i3] = init_box_x[(i3+1)*L-1:i3*L];
		assign b_y[i3] = init_box_y[(i3+1)*L-1:i3*L];
		assign b_en[i3] = ~(~(| b_x[i3]) & ~(| b_y[i3]));
		assign b_init_state[i3] = init_box_state[(i3+1)*2-1:i3*2];
		end
	endgenerate
	// Pipe
	genvar i4;
	wire [L*N3-1:0] pipe_x; 
	wire [L*N3-1:0] pipe_y;
	wire [L-1:0] p_x [N3-1:0]; 
	wire [L-1:0] p_y [N3-1:0]; 
	wire p_en [N3-1:0];
	generate for (i4 = 0; i4 < N3; i4 = i4 + 1) begin: pipes
		assign p_x[i4] = pipe_x[(i4+1)*L-1:i4*L];
		assign p_y[i4] = pipe_y[(i4+1)*L-1:i4*L];
		assign p_en[i4] = ~(~(| p_x[i4]) & ~(| p_y[i4]));
		end
	endgenerate
	// Coin
	genvar i5;
	wire [L*N1-1:0] init_coin_x;
	wire [L*N1-1:0] init_coin_y;
	wire [L-1:0] c_init_x [N1-1:0];
	wire [L-1:0] c_init_y [N1-1:0];
	reg [L-1:0] c_x [N1-1:0];
	reg [L-1:0] c_y [N1-1:0];
	reg c_en [N1-1:0];
	wire [ID-1:0] c_id [N1-1:0]; 
	generate for (i5 = 0; i5 < N1; i5 = i5 + 1) begin: coins
		assign c_init_x[i5] = init_coin_x[(i5+1)*L-1:i5*L];
		assign c_init_y[i5] = init_coin_y[(i5+1)*L-1:i5*L];
		Coin coin(
			.clk(clkdiv[0] & ~pause), .clk_flash_anim(clk_walk_turtle_anim), 
			.rstn(rstn), .id(c_id[i5]));
		end
	endgenerate
	// Init
	StageGenerator generator(.mario_x(init_mario_x), .mario_y(init_mario_y), 
		.map_width(map_width), .goomba_x(init_goomba_x), .goomba_y(init_goomba_y), 
		.turtle_x(init_turtle_x), .turtle_y(init_turtle_y), .box_x(init_box_x), 
		.box_y(init_box_y), .box_state(init_box_state), .pipe_x(pipe_x), .pipe_y(pipe_y), 
		.castle_x(castle_x), .castle_y(castle_y), .coin_x(init_coin_x), .coin_y(init_coin_y));
	// Frame
	integer j;
	reg [1:0] ticks_1;
	reg [1:0] ticks_1_5;
	reg [1:0] ticks_2;
	reg [L-1:0] temp_x, temp_y;
	reg [8:0] temp_bound;
	reg clk_17;

	always@(posedge clkdiv[0]) begin
		if (rstn) begin
			mario_x = init_mario_x; mario_y = init_mario_y;
			hero = 1;
			hero_ticks = 0;
			pause = 0;
			for (j = 0; j < N1; j = j + 1) begin
				c_x[j] = c_init_x[j];
				c_y[j] = c_init_y[j];
				c_en[j] = ~(~(| c_x[j]) & ~(| c_y[j]));
				//t_init_show[j] = ~(~(| t_x[j]) & ~(| t_y[j]));
			end
			for (j = 0; j < N2; j = j + 1) begin
				b_state[j] = b_init_state[j];
			end
			for (j = 0; j < N3; j = j + 1) begin
				g_collapsion[j] = 0;
				g_press[j] = 0;
				g_x[j] = g_init_x[j];
				g_y[j] = g_init_y[j];
				//g_init_show[j] = ~(~(| g_x[j]) & ~(| g_y[j]));
				t_collapsion[j] = 0;
				t_press[j] = 0;
				t_x[j] = t_init_x[j];
				t_y[j] = t_init_y[j];
			end
			ticks_1 = 2'b0;
			ticks_2 = 2'b0;
			ticks_1_5 = 2'b0;
			jump_state = 2'b00;
			clk_17 = clkdiv[17];
			over = 2'b00;
			score = 0;
		end else begin
			if (~clk_17 & clkdiv[17] & ~pause) begin

				if (ticks_1[1]) begin
					
					// Let Mario walks! 
					if (mario_walk) begin
						temp_x = mario_oriental ? mario_x - 1'b1 : mario_x + 1'b1;
						temp_bound = bound(temp_x, mario_y, mario_mw, mario_mh);
						if (~temp_bound[0]) begin
							mario_x = temp_x;
						end
					end
					
					// Let Mario jumps! 
					if (jump_state[1]) begin
						if (jump_state[0]) begin
							// 11: down
							temp_y = mario_y + 1'b1;
							temp_bound = bound(mario_x, temp_y, mario_mw, mario_mh);
							if (temp_bound[0]) begin
								jump_state = 2'b00;
							end else begin
								mario_y = temp_y;
							end
							
						end else begin
							// 10: up
							temp_y = mario_y - 1'b1;
							jump_ticks = jump_ticks + 1'b1;
							if (&jump_ticks) begin
								// Timeout, set up to down
								jump_state = 2'b11;
							end else begin
								temp_bound = bound(mario_x, temp_y, mario_mw, mario_mh);
								if (temp_bound[0]) begin
									jump_state = 2'b11;
									if (temp_bound[1] & ~b_state[temp_bound[8:2]][1]) begin
										if (b_state[temp_bound[8:2]][0]) begin // meets pilz
											if (~level) mario_y = mario_y + 6'd37; // Avoid getting stucked in box.
											upGrade();
											score = score + 20;
										end else begin
											// HACK: make the last coin ascend.
											c_x[N1-1] = b_x[temp_bound[8:2]];
											c_y[N1-1] = b_y[temp_bound[8:2]] - 6'd40;
											c_en[N1-1] = 1; 
											score = score + 5;
										end
										b_state[temp_bound[8:2]] = 2'b10;
									end
								end else begin
									mario_y = temp_y;
								end
							end
						end
					end else begin
						// Check if it's air below Mario.
						temp_bound = bound(mario_x, mario_y + 1'b1, mario_mw, mario_mh);
						if (~temp_bound[0]) begin
							jump_state = 2'b11;
						end
					end

					// Win
					if (mario_x + mario_w >= castle_x) begin
						pause = 1;
						over = 2'b11;
					end

					// Meet a coin
					for (j = 0; j < N1 - 1; j = j + 1) begin
						if (c_en[j] & overlap(mario_x, mario_y, mario_w, mario_h, 
									c_x[j], c_y[j], 40, 40)) begin
							c_en[j] = 0;
							score = score + 5;
						end
					end

					for (j = 0; j < N3; j = j + 1) begin
						// Judge goombar
						if (g_live[j] & overlap(mario_x, mario_y, mario_w, mario_h, 
												g_x[j], g_y[j], g_w[j], g_h[j])) begin
							if (jump_state == 2'b11) begin
								score = score + 10;
								g_press[j] = ~g_press[j];
							end else begin
								// get hurt
								if (~hero) downGrade();
							end
						end
						// Judge turtle
						if (t_init_show[j] & overlap(mario_x, mario_y, mario_w, mario_h, 
												t_x[j], t_y[j], t_w[j], t_h[j])) begin
							if (jump_state == 2'b11) begin
								t_press[j] = ~t_press[j];
								jump_state = 2'b10;
								jump_ticks = 0;
							end else begin
								// get hurt
								if (~hero) downGrade();
							end
						end
					end

					// Set the jump_state to UP.
					if (jump & ~|jump_state) begin
						jump_state = 2'b10;
						jump_ticks = 7'b0;
					end

					// Update the hero state.
					if (hero) begin
						hero_ticks = hero_ticks + 1'b1;
						if (&hero_ticks) begin
							hero = 0;
							hero_ticks = 0;
						end
					end
				
					ticks_1 = 2'b0;
				end

				if (&ticks_1_5) begin
					// Let goombas walks! 
					for (j = 0; j < N3; j = j + 1) begin
						if (g_live[j]) begin
							temp_x = g_oriental[j] ? g_x[j] + 1'b1 : g_x[j] - 1'b1;
							temp_bound = bound(temp_x, g_y[j], g_w[j], g_h[j]);
							if (temp_bound[0]) begin
								g_collapsion[j] = ~g_collapsion[j];
							end else begin
								g_x[j] = temp_x;
							end
						end
					end
					ticks_1_5 = 2'b0;
				end
				
				// Let turtles walks! 
				for (j = 0; j < N3; j = j + 1) begin
					if ((&ticks_2 & ~t_shell[j]) | t_shell_anim[j]) begin
						temp_x = t_oriental[j] ? t_x[j] + 1'b1 : t_x[j] - 1'b1;
						temp_bound = bound(temp_x, t_y[j], t_w[j], t_h[j]);
						if (temp_bound[0]) begin
								t_collapsion[j] = ~t_collapsion[j];
						end else begin
							t_x[j] = temp_x;
						end
					end
				end

				// Lift the gift coin.
				if (c_en[N1-1]) begin
					c_y[N1-1] = c_y[N1-1] - 1'b1;
					if (c_y[N1-1] == 0) begin
						c_en[N1-1] = 0;
					end
				end

				ticks_1 = ticks_1 + 1'b1;
				ticks_2 = ticks_2 + 1'b1;
				ticks_1_5 = ticks_1_5 + 1'b1;
				
			end

			clk_17 = clkdiv[17];

		end
	end
	
	// Output
	
	assign view_x = mario_x + 9'd331 > map_width ? map_width - 10'd641 : (mario_x < 9'd310 ? 13'b0 : mario_x - 9'd310);
	wire [L-1:0] x; assign x = col_addr + view_x;
	wire [L-1:0] y; assign y = row_addr;
	assign cx = mario_x + {1'b0, mario_w[W-1:1]} - view_x;
	assign cy = mario_y - {1'b0, mario_h[W-1:1]}; 
	integer temp_index;

	always@(posedge clkdiv[1]) begin
		if (y + mario_h > mario_y && y <= mario_y && x >= mario_x && x < mario_x + mario_w) begin // Mario
			h = y - mario_y + mario_h - 1'b1;
			w = x - mario_x;
			type = mario_id;
		end else if (y >= 440) begin // Ground
			h = y - 9'd440;
			w = x % 40;
			type = 13;
		end else if (inBox(x, y, castle_x, castle_y, 479, 360)) begin // Castle
			h = y - castle_y + 359;
			w = x - castle_x;
			type = 25;
		end else begin // Goombar
			temp_index = getGoombarIndex(x, y);
			if (temp_index < N3) begin
				h = y - g_y[temp_index] + g_h[temp_index] - 1'b1;
				w = x - g_x[temp_index];
				type = g_id[temp_index];
			end else begin // Turtle
				temp_index = getTurtleIndex(x, y);
				if (temp_index < N3) begin
					h = y - t_y[temp_index] + t_h[temp_index] - 1'b1;
					w = x - t_x[temp_index];
					type = t_id[temp_index];
				end else begin // Box
					temp_index = getBoxIndex(x, y);
					if (temp_index < N2) begin
						h = y + 39 - b_y[temp_index];
						w = x - b_x[temp_index];
						if (b_state[temp_index][1]) begin
							type = b_state[temp_index][0] ? 6'd8 : 6'd1;
						end else begin
							type = 6'd0;
						end
					end else begin // Pipe
						temp_index = getPipeIndex(x, y);
						if (temp_index < N3) begin
							h = y + 11'd79 - p_y[temp_index];
							w = x - p_x[temp_index];
							type = 6'd9;
						end else begin // Coin
							temp_index = getCoinIndex(x, y);
							if (temp_index < N1) begin
								h = y + 11'd39 - c_y[temp_index];
								w = x - c_x[temp_index];
								type = c_id[temp_index]; 
							end else begin // Air
								h = 0;
								w = 0;
								type = 6'd63;
							end
						end
					end
				end
			end
		end
	end
	
	function [6+1+1:0] bound; // box_index(7) | box(1) | bound(1)
		input [L-1:0] x; input [L-1:0] y; input [W-1:0] w; input [W-1:0] h; 
		integer bound_j;
		begin
			bound = 9'b0;
			if (y >= 440) bound[0] = 1; // ground
			else if (x <= 0) bound[0] = 1; // left
			else if (x + w >= map_width - 1'b1) bound[0] = 1; // right
			else begin
				// box
				for (bound_j = 0; bound_j < N2; bound_j = bound_j + 1) begin
					if (b_en[bound_j] & overlap(x, y, w, h, b_x[bound_j], b_y[bound_j], 40, 40)) begin
						bound[8:2] = bound_j;
						bound[1:0] = 2'b11;
					end
				end
				// Pipe
				for (bound_j = 0; bound_j < N3; bound_j = bound_j + 1) begin
					if (p_en[bound_j] & overlap(x, y, w, h, p_x[bound_j], p_y[bound_j], 80, 80)) begin
						bound = 9'b1;
					end
				end
			end
		end
	endfunction

	function integer getBoxIndex;
		input [L-1:0] x; input [L-1:0] y; integer box_j; 
		begin
			getBoxIndex = N2;
			for (box_j = 0; box_j < N2; box_j = box_j + 1) begin
				if (b_en[box_j] & inBox(x, y, b_x[box_j], b_y[box_j], 40, 40)) begin
					getBoxIndex = box_j;
				end
			end
		end
	endfunction

	function integer getPipeIndex;
		input [L-1:0] x; input [L-1:0] y; integer pipe_j; 
		begin
			getPipeIndex = N3;
			for (pipe_j = 0; pipe_j < N3; pipe_j = pipe_j + 1) begin
				if (p_en[pipe_j] & inBox(x, y, p_x[pipe_j], p_y[pipe_j], 80, 80)) begin
					getPipeIndex = pipe_j;
				end
			end
		end
	endfunction

	function integer getCoinIndex;
		input [L-1:0] x; input [L-1:0] y; integer coin_j; 
		begin
			getCoinIndex = N1;
			for (coin_j = 0; coin_j < N1; coin_j = coin_j + 1) begin
				if (c_en[coin_j] & inBox(x, y, c_x[coin_j], c_y[coin_j], 40, 40)) begin
					getCoinIndex = coin_j;
				end
			end
		end
	endfunction

	function overlap;
		input [L-1:0] x1; input [L-1:0] y1; input [W-1:0] w1; input [W-1:0] h1; 
		input [L-1:0] x2; input [L-1:0] y2; input [W-1:0] w2; input [W-1:0] h2; begin
			overlap = x1 + w1 > x2 & x2 + w2 > x1 & y1 - h1 < y2 & y2 - h2 < y1;
		end
	endfunction

	function integer getGoombarIndex;
		input [L-1:0] x;
		input [L-1:0] y;
		integer goombar_j; 
		begin
			getGoombarIndex = N3;
			for (goombar_j = 0; goombar_j < N3; goombar_j = goombar_j + 1) begin
				if (g_init_show[j] && inBox(x, y, g_x[goombar_j], g_y[goombar_j], g_w[goombar_j], g_h[goombar_j])) begin
					getGoombarIndex = goombar_j;
				end
			end
		end
	endfunction
	
	function integer getTurtleIndex;
		input [L-1:0] x; input [L-1:0] y; integer turtle_j; 
		begin
			getTurtleIndex = N3;
			for (turtle_j = 0; turtle_j < N3; turtle_j = turtle_j + 1) begin
				if (t_init_show[j] & inBox(x, y, t_x[turtle_j], t_y[turtle_j], t_w[turtle_j], t_h[turtle_j])) begin
					getTurtleIndex = turtle_j;
				end
			end
		end
	endfunction

	function inBox;
		input [L-1:0] x; input [L-1:0] y; input [L-1:0] obx; input [L-1:0] oby; input [W-1:0] obw; input [W-1:0] obh; 
		begin
			inBox = (y + obh > oby & y <= oby & x >= obx & x < obx + obw);
		end
	endfunction

	task downGrade; 
		begin
			if (level) begin
				hero = 1;
				level = 0;
			end else begin
				// die
				pause = 1;
				over = 2'b11;
			end
		end
	endtask

	task upGrade;
		begin
			level = 1;
			hero = 1;
			hero_ticks = 0;
		end
	endtask

endmodule
