`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2016 01:36:33 PM
// Design Name: 
// Module Name: Script
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


module Script(input logic [2:0] text, input logic clk,rst, output logic [7:0][23:0] outp, output logic textFin );
    logic [2:0] r= 4;logic [2:0] g=2;logic [2:0] b=1;logic [2:0] p=5;logic [2:0] w=7;logic [2:0] c=3;logic [2:0] v=0;logic [2:0] y=6; 
    logic [4:0] timer;
    always_comb
    if(text==3)
        textFin=&timer;
    else textFin=1;
    
    always_ff@(posedge clk)
    if(rst)
    timer=0;
    else
    timer<=timer+1;
    
    logic [7:0][23:0] Lose, Win, Boss;
    
    assign Lose[7]= 0;
    assign Lose[6]= {v,v,r,v,v,v,v,v};
    assign Lose[5]= {v,v,r,v,v,v,v,v};
    assign Lose[4]= {v,v,r,v,v,v,v,v};
    assign Lose[3]= {v,v,r,v,v,v,v,v};
    assign Lose[2]= {v,v,r,r,r,r,v,v};
    assign Lose[1]= 0;
    assign Lose[0]= 0;
    
    assign Win[7] = 0;
    assign Win[6] = {v,g,v,v,v,v,v,g};
    assign Win[5] = {v,g,v,v,v,v,v,g};
    assign Win[4] = {v,v,g,v,v,v,g,v};
    assign Win[3] = {v,v,g,v,g,v,g,v};
    assign Win[2] = {v,v,v,g,v,g,v,v};
    assign Win[1] = 0;
    assign Win[0] = 0;
    
    assign Boss[7] =0;
    assign Boss[6] ={v,v,b,b,b,v,v,v};
    assign Boss[5] ={v,v,b,v,v,b,v,v};
    assign Boss[4] ={v,v,b,v,v,b,v,v};
    assign Boss[3] ={v,v,b,b,b,v,v,v};
    assign Boss[2] ={v,v,b,v,v,b,v,v};
    assign Boss[1] ={v,v,b,v,v,b,v,v};
    assign Boss[0] ={v,v,b,b,b,v,v,v};
    
    
        
    always_comb
    case(text)
    2:outp=Lose;
    3:outp=Boss;
    4:outp=Lose;
    6:outp=Win;
    default outp=0;
    endcase
endmodule
