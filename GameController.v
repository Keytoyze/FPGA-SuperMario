`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:49:56 01/08/2019 
// Design Name: 
// Module Name:    GameController 
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
module GameController(
    input clk, 
    input clk_frame, 
    input [1:0] over, 
    input [8:0] cy, 
    input [9:0] cx, 
    input [8:0] row_addr, 
    input [9:0] col_addr, 
    output rstn, 
    output [11:0] mask
    );

    localparam MAX_RADIUS = 640;
    reg [1:0] zoom_state = 2'b11; // 01: bright; 10: darking; 11: brighting
    reg [9:0] radius = 0;
    reg [2:0] init_ticks = 3'b111;
    assign rstn = ~&init_ticks;

    wire [19:0] x_sqr = (col_addr - cx) * (col_addr - cx);
    wire [19:0] y_sqr = (row_addr - cy) * (row_addr - cy);
    wire [19:0] radius_sqr = radius * radius;
    assign mask = zoom_state == 2'b01 ? 12'hFFF : 
         (x_sqr + y_sqr <= radius_sqr ? 12'hFFF : 12'h0);

    always @(posedge clk) begin
			if (~&init_ticks) init_ticks = init_ticks + 1'b1;
			if (&zoom_state) init_ticks = 3'b0;
    end

    always @(posedge clk_frame) begin

        case (zoom_state)
            2'b10: begin // darking
                radius = radius - 1'b1;
                if (~|radius) begin
                    zoom_state = 2'b11;
                end
            end
            2'b11: begin // brighting
                radius = radius + 1'b1;
                if (radius == MAX_RADIUS) begin
                    zoom_state = 2'b01;
                end
            end

        endcase

        if (over[1] & zoom_state == 2'b01) begin
            zoom_state = 2'b10;
            // TODO: the next stage when winning
        end

    end

endmodule
