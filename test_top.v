`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:16:20 12/27/2018
// Design Name:   Top
// Module Name:   G:/course/Logic and Computer Design/Project/SuperMario/test_top.v
// Project Name:  SuperMario
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_top;

	// Inputs
	reg clk;
	reg [2:0] btn;

	// Outputs
	wire K_ROW;
	wire [3:0] AN;
	wire [7:0] SEGMENT;
	wire [3:0] r;
	wire [3:0] g;
	wire [3:0] b;
	wire hs;
	wire vs;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.clk(clk), 
		.btn(btn), 
		.K_ROW(K_ROW), 
		.AN(AN), 
		.SEGMENT(SEGMENT), 
		.r(r), 
		.g(g), 
		.b(b), 
		.hs(hs), 
		.vs(vs)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		btn = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

