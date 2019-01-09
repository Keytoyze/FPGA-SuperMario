`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:40:05 12/23/2018
// Design Name:   Object
// Module Name:   G:/course/Logic and Computer Design/Project/SuperMario/test_object.v
// Project Name:  SuperMario
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Object
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_object;

	// Inputs
	reg [5:0] id;

	// Outputs
	wire [10:0] h;
	wire [10:0] w;
	wire [18:0] addr;

	// Instantiate the Unit Under Test (UUT)
	Object uut (
		.id(id), 
		.h(h), 
		.w(w), 
		.addr(addr)
	);

	initial begin
		// Initialize Inputs
		id = 0;
	end
	
	always begin
		#10;
		id = id + 1;
		if (id > 35)
			id = 0;
	end
      
endmodule

