`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:27:46 01/12/2019
// Design Name:   Turtle
// Module Name:   G:/course/Logic and Computer Design/Project/SuperMario/test_turtle.v
// Project Name:  SuperMario
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Turtle
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_turtle;

	// Inputs
	reg clk;
	reg clk_walk_anim;
	reg rstn;
	reg initial_show;
	reg collapsion_impulse;
	reg press_impulse;

	// Outputs
	wire [5:0] id;
	wire oriental;
	wire [10:0] w;
	wire [10:0] h;
	wire shell;
	wire shell_anim;

	// Instantiate the Unit Under Test (UUT)
	Turtle uut (
		.clk(clk), 
		.clk_walk_anim(clk_walk_anim), 
		.rstn(rstn), 
		.initial_show(initial_show), 
		.collapsion_impulse(collapsion_impulse), 
		.press_impulse(press_impulse), 
		.id(id), 
		.oriental(oriental), 
		.w(w), 
		.h(h), 
		.shell(shell), 
		.shell_anim(shell_anim)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clk_walk_anim = 0;
		rstn = 1;
		initial_show = 1;
		collapsion_impulse = 0;
		press_impulse = 0;

		// Wait 100 ns for global reset to finish
		#10;
		rstn = 0;
		#50;
		collapsion_impulse = 1;
		#50;
		collapsion_impulse = 0;
		#50;
		press_impulse = 1;
		#50;
		press_impulse = 0;
		#50;
		press_impulse = 1;
        
		// Add stimulus here

	end
	
	always begin
		clk_walk_anim = 0;
		clk = 0;
		#2;
		clk = 1;
		#2;
		clk_walk_anim = 1;
		clk = 0;
		#2;
		clk = 1;
		#2;
	end
      
endmodule

