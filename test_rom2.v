`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:32:13 01/07/2019
// Design Name:   Test
// Module Name:   G:/course/Logic and Computer Design/Project/SuperMario/test_rom2.v
// Project Name:  SuperMario
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Test
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_rom2;

	// Inputs
	reg clka;
	reg [0:0] wea;
	reg [15:0] addra;
	reg [11:0] dina;

	// Outputs
	wire [11:0] douta;

	// Instantiate the Unit Under Test (UUT)
	Test uut (
		.clka(clka), 
		.wea(wea), 
		.addra(addra), 
		.dina(dina), 
		.douta(douta)
	);

	initial begin
		// Initialize Inputs
		wea = 0;
		addra = 0;
		dina = 0;
		#100;
		// Wait 100 ns for global reset to finish
		dina = 1;
      #100;
		dina = 2;
		// Add stimulus here

	end
	
	always begin
		clka = 1;
		#50;
		clka = 0;
		#50;
	end
      
endmodule

