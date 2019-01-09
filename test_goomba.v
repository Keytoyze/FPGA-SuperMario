`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:02:24 12/27/2018
// Design Name:   Goomba
// Module Name:   G:/course/Logic and Computer Design/Project/SuperMario/test_goomba.v
// Project Name:  SuperMario
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Goomba
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_goomba;

	// Inputs
	reg clk;
	reg rstn;
	reg initial_show;
	reg collapsion_impulse;
	reg press_impulse;

	// Outputs
	wire [5:0] id;
	wire oriental;
	wire [10:0] w;
	wire [10:0] h;
	wire live;

	// Instantiate the Unit Under Test (UUT)
	Goomba #(.press_duration(6)) uut(
		.clk(clk), 
		.rstn(rstn), 
		.initial_show(initial_show), 
		.collapsion_impulse(collapsion_impulse), 
		.press_impulse(press_impulse), 
		.id(id), 
		.oriental(oriental), 
		.w(w), 
		.h(h), 
		.live(live)
	);

	initial begin
		// Initialize Inputs
		rstn = 1;
		initial_show = 1;
		collapsion_impulse = 0;
		press_impulse = 0;
		
		#4;
		rstn = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		collapsion_impulse = 1;
		
		#50;
		
		press_impulse = 1;
        
		// Add stimulus here

	end
	
	always begin
		clk = 1;
		#2;
		clk = 0;
		#2;
	end
	
      
endmodule

