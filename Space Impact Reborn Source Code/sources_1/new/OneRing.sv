`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2016 01:23:43 PM
// Design Name: 
// Module Name: OneRing
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


module topModule(input logic clk, rst, pause, input logic [3:0] btn, output logic  [7:0] rowsOut, output logic shcp, stcp, mr, oe, ds, 
output logic [3:0] an, output logic [0:6] seg, output logic dp);
    //btn3 vuruþ, btn2 aþaðý, btn1 yukarý, btn0 özel
    
    
    logic  wonGame, lostGame, bossLost, timeLeft1, timeLeft0, 
health1, health0, textFin, rstGame, rstBoss, pauseGame, bossPause, alev, 
mux1, mux0, rstText, text2, text1, text0;


    controller brain(clk, rst, wonGame, lostGame, bossLost, timeLeft1, timeLeft0, 
health1, health0, pause, textFin, rstGame, rstBoss, pauseGame, bossPause, alev, 
mux1, mux0, rstText, text2, text1, text0);
    
    DataRoad thebody( wonGame, lostGame, bossLost, timeLeft1, timeLeft0, 
health1, health0, textFin,  shcp, stcp, mr, oe, ds ,rowsOut,
 rstGame, rstBoss, pauseGame, bossPause, alev, 
mux1, mux0, rstText, text2, text1, text0, clk,btn, an, seg, dp);
    


endmodule
