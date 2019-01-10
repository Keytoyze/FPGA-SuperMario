`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:38:44 12/23/2018 
// Design Name: 
// Module Name:    Top 
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
module Top(
	input clk, 
	input [2:0] btn, 
	output K_ROW, 
	//output [3:0] AN, 
	//output [7:0] SEGMENT, 
	output [3:0] sout, 
	output [3:0] r, 
	output [3:0] g, 
	output [3:0] b, 
	output hs, vs    // horizontal and vertical synchronization
    );

	wire [31:0] div;
	clkdiv m1(.clk(clk), .rst(1'b0), .clkdiv(div));
	
	wire left, right, jump;
	Input Input(.btn(btn), .clk_1ms(div[17]), .left(left), .right(right), .jump(jump), 
		.K_ROW(K_ROW));

	wire [8:0] row_addr;
	wire [9:0] col_addr;
	wire [5:0] type; 
	wire [10:0] h; 
	wire [10:0] w; 
	wire [1:0] over;
	wire [11:0] mask;
	wire stage;
	reg [2:0] init = 0;
	wire rstn;
	wire [31:0] score;

	wire [8:0] cy;
	wire [9:0] cx;

	World world(.clkdiv(div), .rstn(rstn), .jump(jump), .left(left), .right(right), 
		.row_addr(row_addr), .col_addr(col_addr), .type(type), .h(h), .w(w), .over(over), 
		.cx(cx), .cy(cy), .score(score));
	
	Output Output(.clkdiv(div), .type(type), .h(h), .w(w), .num(score), //.AN(AN), .SEGMENT(SEGMENT), 
	.row_addr(row_addr), .col_addr(col_addr), .r(r), .g(g), .b(b), 
		.hs(hs), .vs(vs), .mask(mask), .sout(sout));

	GameController Controller(.clk(clk), .clk_frame(div[17]), .over(over), .cy(cy), .cx(cx), 
		.row_addr(row_addr), .col_addr(col_addr), .rstn(rstn), .mask(mask));

		
	// always@(posedge div[0]) begin
	// 	if (~&init) begin
	// 		rstn = 1'b1;
	// 		init = init + 1'b1;
	// 	end else begin
	// 		rstn = 1'b0;
	// 	end
	// end

endmodule
  