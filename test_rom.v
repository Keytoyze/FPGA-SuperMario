`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:11:59 12/23/2018
// Design Name:   Image
// Module Name:   G:/course/Logic and Computer Design/Project/SuperMario/test_rom.v
// Project Name:  SuperMario
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Image
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_rom;

	// Inputs
	reg clka;
	reg [0:0] wea;
	reg [18:0] addra;
	reg [11:0] dina;

	// Outputs
	wire [11:0] douta;

	// Instantiate the Unit Under Test (UUT)
	Image uut (
		.clka(clka), 
		.wea(wea), 
		.addra(addra), 
		.dina(dina), 
		.douta(douta)
	);

	initial begin
		// Initialize Inputs
		clka = 0;
		wea = 0;
		addra = 0;
		dina = 0;
		for (addra = 262252; addra > 262240; addra = addra - 1) begin
			#50;
		end
	end
	
	always begin
		clka = 1;
		#20;
		clka = 0;
		#20;
	end
      
endmodule

