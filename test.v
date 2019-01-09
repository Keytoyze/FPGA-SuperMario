`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:41:56 12/23/2018
// Design Name:   image_splayer1l
// Module Name:   G:/course/Logic and Computer Design/Project/SuperMario/test.v
// Project Name:  SuperMario
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: image_splayer1l
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg clka;
	reg [0:0] wea;
	reg [10:0] addra;
	reg [11:0] dina;

	// Outputs
	wire [11:0] douta;

	// Instantiate the Unit Under Test (UUT)
	image_splayer1l uut (
		.clka(clka), 
		.wea(wea), 
		.addra(addra), 
		.dina(dina), 
		.douta(douta)
	);

	initial begin
		// Initialize Inputs
		wea = 0;
		for (addra = 0; addra <= 20; addra = addra + 1) begin
			#20;
		end
      
		// Add stimulus here

	end
	always begin
		clka = 1;
		#10;
		clka = 0;
		#10;
	end
      
endmodule

