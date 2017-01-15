`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2016 01:30:05 PM
// Design Name: 
// Module Name: DataRoad
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


module DataRoad(output logic wonGame, lostGame, bossLost, timeLeft1, timeLeft0, 
health1, health0, textFin,  shcp, stcp, mr, oe, ds , output logic  [7:0] rowsOut,
 input logic rstGame, rstBoss, pauseGame, bossPause, alev, 
mux1, mux0, rstText, text2, text1, text0, clk, input logic [3:0] btn,
output logic [3:0] AN, output logic [0:6] C, output logic DP);

    logic[5:0] killCount;
    logic [3:0] pulsed; logic [2:0] realButtons;
    logic [7:0][23:0] inp, raw, transposed, scriptout, bossOut, gameOut, zero;
    logic scriptclk, gameclk, bossclk;
    /*pulse_controller btn3(clk, btn[3], 0, pulsed[3]);
    pulse_controller btn2(clk, btn[2], 0, pulsed[2]);
    pulse_controller btn1(clk, btn[1], 0, pulsed[1]);
    pulse_controller btn0(clk, btn[0], 0, pulsed[0]);*/
    buttonFixer fixfixbaby(btn,realButtons);
    
    assign zero=0;
    
    clockMaster pitBoss(clk,scriptclk, gameclk, bossclk);  
    led outp(clk, inp, rowsOut, shcp, stcp, mr, oe, ds);
    Script texts({text2,text1,text0},scriptclk, rstText,scriptout, textFin);
    Boss theboss(bossclk, rstBoss, bossPause, alev, realButtons, bossLost, {timeLeft1, timeLeft0}, {health1,health0}, bossOut);
    theGame theOyun (gameclk, rstGame, pauseGame, realButtons, gameOut, wonGame, lostGame, killCount);
    
    always_ff@(posedge clk)
    case({mux1,mux0})
    3:raw<=bossOut;
    2:raw<=gameOut;
    1:raw<=scriptout;
    default: raw<=zero;
    endcase
    
    transpose tr(raw, transposed);
    forTheLed fixer(transposed, inp); 
    
    display_controller seven(clk, rstGame, 3,0,0,killCount/10,killCount%10,AN,C,DP);


endmodule
