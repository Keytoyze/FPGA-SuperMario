`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:00:14 12/23/2018 
// Design Name: 
// Module Name:    Object 
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
// Map object id to height, width and address in the rom.
//box: 0
//boxempty: 1
//bush5: 2
//cloud1: 3
//coin1: 4
//coin2: 5
//coin3: 6
//coin4: 7
//crackstone: 8
//full_pipe_left: 9
//goomba1: 10
//goomba2: 11
//goomba3: 12
//grass: 13
//pilz: 14
//player1l: 15
//player1r: 16
//player2l: 17
//player2r: 18
//player3l: 19
//player3r: 20
//shell1: 21
//shell2: 22
//shell3: 23
//shell4: 24
//smallcastle: 25
//splayer1l: 26
//splayer1r: 27
//splayer2l: 28
//splayer2r: 29
//splayer3l: 30
//splayer3r: 31
//turtlel1: 32
//turtlel2: 33
//turtler1: 34
//turtler2: 35

module Object(
	input [5:0] id, // 0 - 35 (64)
	output reg [10:0] h, 
	output reg [10:0] w, 
	output reg [18:0] addr
);

	always@(*) begin
		case(id)
			0: begin
				h <= 40;
				w <= 40;
				addr <= 0;
			end
			1: begin
				h <= 40;
				w <= 40;
				addr <= 1600;
			end
			2: begin
				h <= 43;
				w <= 134;
				addr <= 3200;
			end
			3: begin
				h <= 92;
				w <= 158;
				addr <= 8962;
			end
			4: begin
				h <= 40;
				w <= 40;
				addr <= 23498;
			end
			5: begin
				h <= 40;
				w <= 40;
				addr <= 25098;
			end
			6: begin
				h <= 40;
				w <= 40;
				addr <= 26698;
			end
			7: begin
				h <= 40;
				w <= 40;
				addr <= 28298;
			end
			8: begin
				h <= 40;
				w <= 40;
				addr <= 29898;
			end
			9: begin
				h <= 80;
				w <= 80;
				addr <= 31498;
			end
			10: begin
				h <= 40;
				w <= 40;
				addr <= 37898;
			end
			11: begin
				h <= 40;
				w <= 40;
				addr <= 39498;
			end
			12: begin
				h <= 40;
				w <= 40;
				addr <= 41098;
			end
			13: begin
				h <= 40;
				w <= 40;
				addr <= 42698;
			end
			14: begin
				h <= 39;
				w <= 40;
				addr <= 44298;
			end
			15: begin
				h <= 77;
				w <= 42;
				addr <= 45858;
			end
			16: begin
				h <= 77;
				w <= 42;
				addr <= 49092;
			end
			17: begin
				h <= 78;
				w <= 45;
				addr <= 52326;
			end
			18: begin
				h <= 77;
				w <= 44;
				addr <= 55836;
			end
			19: begin
				h <= 73;
				w <= 44;
				addr <= 59224;
			end
			20: begin
				h <= 74;
				w <= 44;
				addr <= 62436;
			end
			21: begin
				h <= 33;
				w <= 42;
				addr <= 65692;
			end
			22: begin
				h <= 32;
				w <= 42;
				addr <= 67078;
			end
			23: begin
				h <= 33;
				w <= 42;
				addr <= 68422;
			end
			24: begin
				h <= 33;
				w <= 39;
				addr <= 69808;
			end
			25: begin
				h <= 360;
				w <= 479;
				addr <= 71095;
			end
			26: begin
				h <= 42;
				w <= 40;
				addr <= 243535;
			end
			27: begin
				h <= 42;
				w <= 40;
				addr <= 245215;
			end
			28: begin
				h <= 42;
				w <= 39;
				addr <= 246895;
			end
			29: begin
				h <= 42;
				w <= 39;
				addr <= 248533;
			end
			30: begin
				h <= 42;
				w <= 40;
				addr <= 250171;
			end
			31: begin
				h <= 42;
				w <= 40;
				addr <= 251851;
			end
			32: begin
				h <= 54;
				w <= 39;
				addr <= 253531;
			end
			33: begin
				h <= 55;
				w <= 41;
				addr <= 255637;
			end
			34: begin
				h <= 54;
				w <= 39;
				addr <= 257892;
			end
			35: begin
				h <= 55;
				w <= 41;
				addr <= 259998;
			end
			default: begin
				h <= 1;
				w <= 1;
				addr <= 0;
			end
		endcase

	end

endmodule
