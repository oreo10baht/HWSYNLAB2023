`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2023 01:57:20 PM
// Design Name: 
// Module Name: clockDiv
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


module clockDiv(
       input clk,
       output reg baudrate
    );
    integer counter;
    always @(posedge clk)
    begin
        counter = counter + 1;
        if (counter == 325)
        begin
            counter = 0;
            baudrate = ~baudrate;
        end
    end
endmodule
