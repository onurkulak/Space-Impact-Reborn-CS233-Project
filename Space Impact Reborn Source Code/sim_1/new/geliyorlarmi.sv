`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2016 11:10:39 AM
// Design Name: 
// Module Name: geliyorlarmi
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


module geliyorlarmi();

    logic clk; logic rst; logic [2:0] cnt; ;logic [7:0][23:0] outp;
    logic win, lose,pause; 
        theGame uut(clk, rst, pause, cnt, outp, win , lose);
        initial begin
        cnt=0; rst = 1; pause=0;
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
                cnt++;
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
        $monitor($time, clk, rst, cnt, outp, win , lose);
endmodule
