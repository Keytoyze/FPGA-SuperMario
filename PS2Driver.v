`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:08:48 01/10/2019 
// Design Name: 
// Module Name:    PS2Driver 
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
module PS2Driver(

    input wire clk, 
    input wire rst,
    input wire ps2_clk, 
    input wire ps2_data,
    output reg [7:0] ps2_byte,
    output reg ps2_state // 1: press; 2: release
    );
    
    reg ps2_clk_r[0:2];
    wire neg_ps2_clk = ~ps2_clk_r[1] & ps2_clk_r[2];
    
	// Detects the negative edge of ps2_clk by sampling
    always @ (posedge clk, negedge rst) begin
        if (!rst) begin
            ps2_clk_r[0] <= 1'b0;
            ps2_clk_r[1] <= 1'b0;
            ps2_clk_r[2] <= 1'b0;
        end
        else begin
            ps2_clk_r[0] <= ps2_clk;
            ps2_clk_r[1] <= ps2_clk_r[0];
            ps2_clk_r[2] <= ps2_clk_r[1];
        end
    end
    
    reg [7:0] ps2_temp;
    reg [3:0] counter;
    
    always @ (posedge clk, negedge rst) begin 
        if (!rst) begin
            counter <= 4'h0;
            ps2_temp <= 8'h00;
        end
        else if (neg_ps2_clk) begin
            case (counter) 
                4'h0: begin
                    counter <= counter + 4'h1;
                end
                4'h1: begin
                    counter <= counter + 4'h1;
                    ps2_temp[0] <= ps2_data;
                end
                4'h2: begin
                    counter <= counter + 4'h1;
                    ps2_temp[1] <= ps2_data;
                end
                4'h3: begin
                    counter <= counter + 4'h1;
                    ps2_temp[2] <= ps2_data;
                end
                4'h4: begin
                    counter <= counter + 4'h1;
                    ps2_temp[3] <= ps2_data;
                end
                4'h5: begin
                    counter <= counter + 4'h1;
                    ps2_temp[4] <= ps2_data;
                end
                4'h6: begin
                    counter <= counter + 4'h1;
                    ps2_temp[5] <= ps2_data;
                end
                4'h7: begin
                    counter <= counter + 4'h1;
                    ps2_temp[6] <= ps2_data;
                end
                4'h8: begin
                    counter <= counter + 4'h1;
                    ps2_temp[7] <= ps2_data;
                end
                4'h9: begin
                    counter <= counter + 4'h1;
                end
                4'hA: begin
                    counter <= 4'h0;
                end
            endcase
        end
    end
    
    reg key_f0;
    
    always @ (posedge clk, negedge rst) begin
        if (!rst) begin
            key_f0 <= 1'b0;
            ps2_state <= 1'b0;
        end
        else if (counter == 4'hA && neg_ps2_clk) begin
            if (ps2_temp == 8'hF0)
                key_f0 <= 1'b1;
            else begin
                if (!key_f0) begin
                    ps2_state <= 1'b1;
                    ps2_byte <= ps2_temp;
                end
                else begin
                    ps2_state <= 1'b0;
                    ps2_byte <= ps2_temp;
                    key_f0 <= 1'b0;
                end
            end
        end
    end
    

endmodule
