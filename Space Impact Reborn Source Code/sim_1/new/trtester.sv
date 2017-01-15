`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2016 06:52:59 PM
// Design Name: 
// Module Name: trtester
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


module trtester();
    logic [7:0][23:0] raw, trans;
    forTheLed uut(raw,trans);
    initial 
    begin
    #10;
    raw[7]=24'b111_111_111_111_111_111_111_111;
    raw[6]=24'b0;
    raw[5]=24'b0;
    raw[4]=24'b0;
    raw[3]=24'b111_111_111_111_111_000000000;
    raw[2]=24'b101_101_101_101_101_101_101_101;
    raw[1]=24'b0;
    raw[0]=24'b0;
    #1000;
    end
    initial
    $monitor($time, raw, trans);
    
    
endmodule
