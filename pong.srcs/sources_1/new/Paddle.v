module Paddle(
    input wire clk,
    input wire reset,
    input paddle_left_pos,
    input wire direction,
    output reg y_pos
    );
    localparam PADDLE_WIDTH = 3;
    localparam PADDLE_HEIGHT = 72;
    localparam PADDLE_VEL = 4;
    
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            begin
                y_pos = (480/2) - 36;
            end
        else
            begin
                if (y_pos + PADDLE_HEIGHT < 480 && y_pos > 0)
                    begin
                        y_pos = y_pos + (direction * PADDLE_VEL);
                    end
            end
    end
endmodule