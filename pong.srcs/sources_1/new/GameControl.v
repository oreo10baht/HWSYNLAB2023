module GameControl(
    input wire clk,
    input wire reset,
    input wire startGame,
    input wire pauseGame,
    input wire restartGame,
    input wire beginRound,
    input wire player1_direction,
    input wire player2_direction
);
    
    
    reg [2:0] gameState;
    parameter BEGIN = 3'd0;
    parameter PLAYING = 3'd1;
    parameter ROUNDSTART = 3'd2;
    parameter GAMEOVER = 3'd3;
    parameter PAUSE = 3'd4; 
    
    wire baudrate;
    clockDiv clkDiv(clk, baudrate);
    
    reg [3:0] p1_score_tenth, p1_score_ones, p2_score_tenth, p2_score_ones;
    
    reg ball_x_direction, ball_y_direction;
    reg ball_x_vel, ball_y_vel;
    reg [9:0] ball_x_pos, ball_y_pos;
    reg add_score_p1, add_score_p2;
    reg resetBall;
    Ball ball(baudrate, resetBall, ball_x_direction, ball_y_direction, ball_x_vel, ball_y_vel, ball_x_pos, ball_y_pos, add_score_p1, add_score_p2);
    
    parameter p1_left = 40;
    parameter p2_left = 600;
    reg p1_y_pos, p2_y_pos;
    
    Paddle player1(baudrate, reset, p1_left, p1_direction, p1_y_pos);
    Paddle player2(baudrate, reset, p2_left, p2_direction, p2_y_pos);
    Scoreboard scoreboard(baudrate);
    Collision collsionDetection(baudrate, reset, p1_left, p2_left, p1_y_pos, p2_y_pos, ball_x_pos, ball_y_pos, ball_x_direction, ball_y_direction, ball_x_vel, ball_y_vel);
    
    wire [10:0] rom_addr;
    ascii_rom ascii(clk, rom_addr, data);
    
    always @(posedge baudrate or posedge reset)
    begin
        if (reset || gameState == BEGIN)
            begin
                resetBall = 1;
                p1_score_tenth = 0;
                p1_score_ones = 0;
                p2_score_tenth = 0;
                p2_score_ones = 0;
                if (beginRound)
                    begin
                        gameState = PLAYING;
                    end
            end
        else if (gameState == PLAYING)
            begin
                resetBall = 0;
                if (add_score_p1 || add_score_p2)
                    begin
                        gameState = ROUNDSTART;
                    end
            end
        else if (gameState == ROUNDSTART)
            begin
                if ((p1_score_tenth == 9 && p1_score_ones == 9) || (p2_score_tenth == 9 && p2_score_ones == 9))
                    begin
                        gameState = GAMEOVER;
                    end
                if (p1_score_ones + add_score_p1 > 9)
                    begin
                        p1_score_tenth = p1_score_tenth + 1;
                        p1_score_ones = 0;
                        add_score_p1 = 0;
                        add_score_p2 = 0;
                    end
                if (p2_score_ones + add_score_p2 > 9)
                    begin
                        p2_score_tenth = p2_score_tenth + 1;
                        p2_score_ones = 0;
                        add_score_p1 = 0;
                        add_score_p2 = 0;
                    end
                if (beginRound)
                    begin
                        gameState = PLAYING;
                    end
            end
        else if (gameState == GAMEOVER)
            begin
            end
        else if (gameState == PAUSE)
            begin
            end
        
    end

endmodule
