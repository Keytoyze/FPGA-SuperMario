`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:00:04 12/27/2018
// Design Name:   World
// Module Name:   G:/course/Logic and Computer Design/Project/SuperMario/test_world.v
// Project Name:  SuperMario
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: World
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_world;

	// Inputs
	reg [31:0] div = 0;
	reg rstn;
	reg jump;
	reg left;
	reg right;
	reg [8:0] row_addr;
	reg [9:0] col_addr;
	wire [12:0] mario_x;
	wire [12:0] mario_y;
	wire bounds;
	

	// Outputs
	wire [5:0] type;
	wire [10:0] h;
	wire [10:0] w;
	wire [1:0] jump_state;

	// Instantiate the Unit Under Test (UUT)
	World uut (
		.clkdiv(div), 
		.rstn(rstn), 
		.jump(jump), 
		.left(left), 
		.right(right), 
		.row_addr(row_addr), 
		.col_addr(col_addr), 
		.type(type), 
		.h(h), 
		.w(w), 
		.mario_x(mario_x), 
		.mario_y(mario_y), 
		.jump_state(jump_state), 
		.bounds(bounds)
	);

	initial begin
		// Initialize Inputs
		rstn = 1;
		jump = 0;
		left = 0;
		right = 0;
		row_addr = 0;
		col_addr = 0;
		
		#8;
		rstn = 0;
		
		#100;
		left = 1;
		
		//jump = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin
		div = div + 1;
		#2;
	end
      
endmodule

