module Collision(
    input wire clk,
    input wire reset,
    input wire paddle1_x_pos,
    input wire paddle2_x_pos,
    input wire paddle1_y_pos,
    input wire paddle2_y_pos,
    input wire ball_x_pos,
    input wire ball_y_pos,
    output reg ball_x_direction,
    output reg ball_y_direction,
    output reg ball_x_vel,
    output reg ball_y_vel
    );
    
    localparam PADDLE_WIDTH = 3;
    localparam PADDLE_HEIGHT = 72;
    localparam BALL_SIZE = 8;
    
    always @(posedge clk or posedge reset)
    begin
        if (paddle1_x_pos + PADDLE_WIDTH == ball_x_pos && paddle1_y_pos <= ball_y_pos && paddle1_y_pos + PADDLE_HEIGHT >= ball_y_pos)
            begin
                ball_x_direction = 1;
            end
        else if (paddle2_x_pos == ball_x_pos + BALL_SIZE && paddle2_y_pos <= ball_y_pos && paddle2_y_pos + PADDLE_HEIGHT >= ball_y_pos)
            begin
                ball_x_direction = -1;
            end
        if (ball_y_pos <= 0)
            begin
                ball_y_direction = 1;
            end
        else if (ball_y_pos + BALL_SIZE >= 480)
            begin
                ball_y_direction = -1;
            end
    end
endmodule