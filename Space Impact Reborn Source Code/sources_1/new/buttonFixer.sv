`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2016 02:00:04 PM
// Design Name: 
// Module Name: buttonFixer
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


module buttonFixer(input logic [3:0] btn, output logic [2:0] realButtons);

    always_comb
    if(btn[3])realButtons=0;
    else if (btn[2]) realButtons=1;
    else if (btn[1]) realButtons=2;
    else if (btn[0]) realButtons=3;
    else realButtons=5;
endmodule
