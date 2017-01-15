`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2016 01:51:37 AM
// Design Name: 
// Module Name: controller
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


module controller
(input logic clk, rst, wonGame, lostGame, bossLost, timeLeft1, timeLeft0, 
health1, health0, pause, textFin, output logic rstGame, rstBoss, pauseGame, bossPause, alev, 
mux1, mux0, rstText, text2, text1, text0);
    logic pauseBoss;
    assign bossPause=pause||pauseBoss;
    assign pauseGame=pause;
    
    logic [3:0] state, next;
    always_ff@(posedge clk)
    if(rst) state<=0;
    else state<=next;
    
    always_comb
    case(state)
    0:next=1;
    1:if(textFin)next=2;
    else next=1;
    2:if(wonGame) next=4;
      else if (lostGame) next=3;
      else next=2;
    3:next=3;
    4:if(textFin)next=5;
    else next=4;
    5: if(bossLost) next=6;
       else if(!timeLeft1) next=7;
       else if(!health1) next=9;
       else next=5;
    6:next=6;
    7:if(finText)next=8;
    else next=7;
    8:if(bossLost)next=6;
    else if(!health1) next=13;
    else next=8;
    9:if(finText) next=10;
    else next=9;
    10:if(bossLost)next=6;
    else if (!health0) next=14;
    else if(!timeLeft1) next=11;
    else next=10;
    11:if(finText)next=12;
    else next=11;
    12:if(bossLost)next=6;
    else if (!health0) next=14;
    else next=12;
    13:if(finText)next=12;
    else next=13;
    14:next=14;
    default:next=0;
    endcase
    
    always_comb
    case(state)
    0:begin
    rstGame=1; rstBoss=1; pauseBoss=0; alev=0; 
    mux1=0; mux0=0; rstText=1; text2=0; text1=0; text0=0;
    end
    1:begin
    rstGame=1; rstBoss=1; pauseBoss=0; alev=0; 
    mux1=0; mux0=1; rstText=0; text2=0; text1=0; text0=1;
    end
    2:begin
    rstGame=0; rstBoss=1; pauseBoss=0; alev=0; 
    mux1=1; mux0=0; rstText=1; text2=0; text1=0; text0=0;
    end
    3:begin
    rstGame=1; rstBoss=1; pauseBoss=0; alev=0; 
    mux1=0; mux0=1; rstText=0; text2=0; text1=1; text0=0;
    end
    4:begin
    rstGame=1; rstBoss=1; pauseBoss=0; alev=0; 
    mux1=0; mux0=1; rstText=0; text2=0; text1=1; text0=1;
    end
    5:begin
    rstGame=1; rstBoss=0; pauseBoss=0; alev=0; 
    mux1=1; mux0=1; rstText=1; text2=0; text1=0; text0=0;
    end
    6:begin
    rstGame=1; rstBoss=1; pauseBoss=0; alev=0; 
    mux1=0; mux0=1; rstText=0; text2=1; text1=0; text0=0;
    end
    7:begin
    rstGame=1; rstBoss=0; pauseBoss=1; alev=0; 
    mux1=0; mux0=1; rstText=0; text2=1; text1=1; text0=1;
    end
    8:begin
    rstGame=1; rstBoss=0; pauseBoss=0; alev=0; 
    mux1=1; mux0=1; rstText=1; text2=0; text1=0; text0=0;
    end
    9:begin
    rstGame=1; rstBoss=0; pauseBoss=1; alev=0; 
    mux1=0; mux0=1; rstText=0; text2=1; text1=0; text0=1;
    end
    10:begin
    rstGame=1; rstBoss=0; pauseBoss=0; alev=1; 
    mux1=1; mux0=1; rstText=1; text2=0; text1=0; text0=0;
    end
    11:begin
    rstGame=1; rstBoss=0; pauseBoss=1; alev=0; 
    mux1=0; mux0=1; rstText=0; text2=1; text1=1; text0=1;
    end
    12:begin
    rstGame=1; rstBoss=0; pauseBoss=0; alev=1; 
    mux1=1; mux0=1; rstText=1; text2=0; text1=0; text0=0;
    end
    13:begin
    rstGame=1; rstBoss=0; pauseBoss=1; alev=0; 
    mux1=0; mux0=1; rstText=0; text2=1; text1=0; text0=1;
    end
    14:begin
    rstGame=1; rstBoss=1; pauseBoss=0; alev=0; 
    mux1=0; mux0=1; rstText=0; text2=1; text1=1; text0=0;
    end
    default:begin
    rstGame=1; rstBoss=1; pauseBoss=0; alev=0; 
    mux1=0; mux0=0; rstText=1; text2=0; text1=0; text0=0;
    end         
    endcase    
          
endmodule
