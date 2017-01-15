`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2016 06:45:13 PM
// Design Name: 
// Module Name: deboss
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


module deboss();
    
    logic clk; logic rst; logic [2:0] cnt; ;logic [7:0][23:0] outp;
        logic  lose,pause, alev; logic [1:0] health, timeLeft;
            Boss uut(clk, rst, pause,alev, cnt, lose, timeLeft, health, outp);
            initial begin
            cnt=0; rst = 1; pause=0; alev=0;
            for(int i = 0; i<10; i++)
            begin
            clk=0;
            #10;
            clk=1;
            #10;
            end
            
            
            cnt=0; rst = 0;
                    for(int j=0; j<30;j++)
                    begin
                    for(int i = 0; i<60; i++)
                    begin
                    clk=0;
                    #2;
                    clk=1;
                    #2;
                    end
                    end
                    end
            initial 
            $monitor($time, clk, rst, cnt, outp, lose);
endmodule
