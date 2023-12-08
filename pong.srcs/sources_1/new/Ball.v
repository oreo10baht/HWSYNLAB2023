`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2023 01:46:52 PM
// Design Name: 
// Module Name: Ball
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Ball(
    input wire clk,
    input wire reset,
    input x_direction,
    input y_direction,
    input x_vel,
    input y_vel,
    output reg [9:0] x_pos,
    output reg [9:0] y_pos,
    output reg add_score_p1,
    output reg add_score_p2
    );
    
localparam BALL_SIZE = 8;

always @(posedge clk or posedge reset)
begin
    if (reset)
        begin
            x_pos = (640/2) - 4;
            y_pos = (480/2) - 4;
            add_score_p1 = 0;
            add_score_p2 = 0;   
        end
    else
        begin
            if (x_pos < 640 - BALL_SIZE || x_pos > 0)
                begin
                    x_pos = x_pos + (x_direction * x_vel);
                    add_score_p1 = 0;
                    add_score_p2 = 0;
                end
            if (y_pos < 480 - BALL_SIZE || y_pos > 0)
                begin
                    y_pos = y_pos + (y_direction * y_vel);
                    add_score_p1 = 0;
                    add_score_p2 = 0;
                end
            if (x_pos <= 0)
                begin
                    add_score_p2 = 1;
                end
            if (x_pos + BALL_SIZE >= 640)
                begin
                    add_score_p1 = 1;
                end
        end
end 
endmodule
