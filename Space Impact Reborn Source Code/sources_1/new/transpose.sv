`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2016 02:34:13 PM
// Design Name: 
// Module Name: transpose
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


module transpose(input logic [7:0][23:0] raw, output logic [7:0][23:0] transposed );
    always_comb
    for(int i=0; i<8; i++)
    for(int j=0; j<8; j++)
    begin
    transposed[j][i*3]=raw[i][j*3];
    transposed[j][i*3+1]=raw[i][j*3+1];
    transposed[j][i*3+2]=raw[i][j*3+2];
    end
    
endmodule
