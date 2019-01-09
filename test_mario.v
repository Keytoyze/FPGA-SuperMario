`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:02:24 12/27/2018
// Design Name:   Mario
// Module Name:   G:/course/Logic and Computer Design/Project/SuperMario/test_mario.v
// Project Name:  SuperMario
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Mario
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_mario;

	// Inputs
	reg clk;
	reg clk_walk_anim;
	reg clk_hero_anim;
	reg rstn;
	reg left;
	reg right;
	reg jump;
	reg upgrade_impulse;
	reg downgrade_impulse;
	reg hero_impulse;

	// Outputs
	wire level;
	wire hero;
	wire [5:0] id;
	wire [10:0] w;
	wire [10:0] h;
	wire [6:0] state;

	// Instantiate the Unit Under Test (UUT)
	Mario uut (
		.clk(clk), 
		.clk_walk_anim(clk_walk_anim), 
		.clk_hero_anim(clk_hero_anim), 
		.rstn(rstn), 
		.left(left), 
		.right(right), 
		.jump(jump), 
		.upgrade_impulse(upgrade_impulse), 
		.downgrade_impulse(downgrade_impulse), 
		.hero_impulse(hero_impulse), 
		.level(level), 
		.hero(hero), 
		.id(id), 
		.w(w), 
		.h(h), 
		.state(state)
	);

	initial begin
		// Initialize Inputs
		rstn = 1;
		left = 0;
		right = 0;
		jump = 0;
		upgrade_impulse = 0;
		downgrade_impulse = 0;
		hero_impulse = 0;
		
		#4;
		rstn = 0;
		#20;
		
		left = 1;
		#20;
		
		right = 1;
		#20;
		
		left = 0;
		#20;
		
		right = 0;
		#50;
		
		jump = 1;
		#20;
		
		jump = 0;
		upgrade_impulse = 1;
		#2;
		upgrade_impulse = 0;
		#20;
		
		downgrade_impulse = 1;
		#2;
		downgrade_impulse = 0;
		#20;
		
		hero_impulse = 1;
		#2;
		hero_impulse = 0;
		#20;
		
		rstn = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end

	always begin
		clk_walk_anim = 0;
		clk_hero_anim = 0;
		clk = 0;
		#2;
		clk = 1;
		#2;
		clk_walk_anim = 1;
		clk_hero_anim = 1;
		clk = 0;
		#2;
		clk = 1;
		#2;
	end
  
endmodule

