`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2016 02:34:27 PM
// Design Name: 
// Module Name: forTheLed
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


module forTheLed(input logic [7:0][23:0] raw, output logic [7:0][23:0] fixed );
    always_comb 
    for(int i=0; i<8; i++)
    for(int j=0; j<8; j++)
    begin
    fixed[i][j]=raw[i][j*3];
    fixed[i][8+j]=raw[i][j*3+1];
    fixed[i][16+j]=raw[i][j*3+2];
    end
    
endmodule
