`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:06:39 01/07/2019 
// Design Name: 
// Module Name:    TextMapper 
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
module TextMapper(
	input [1:0] over, // 0x: sceen; 10: gameover; 11: win
	input [8:0] row_addr, // pixel ram row address, 480 (512) lines
	input [9:0] col_addr, // pixel ram col address, 640 (1024) pixels
	output reg [11:0] addr_offset
   );
	
	always @* begin
		if (over[1]) begin
			if (over[0]) begin
				if (col_addr <= 146 | col_addr >= 592 | row_addr <= 204 | row_addr >= 275) begin
					addr_offset = 0;
				end else begin
					addr_offset = 27136 + (row_addr - 205) * 640 + col_addr - 147;
				end
			end else begin
				if (col_addr <= 107 | col_addr >= 532 | row_addr <= 207 | row_addr >= 272) begin
					addr_offset = 0;
				end else begin
					addr_offset = (row_addr - 208) * 640 + col_addr - 108;
				end
			end
		end else begin
			addr_offset = 0;
		end
	end


endmodule
