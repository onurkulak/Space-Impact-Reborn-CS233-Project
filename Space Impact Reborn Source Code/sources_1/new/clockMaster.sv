`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2016 01:43:47 PM
// Design Name: 
// Module Name: clockMaster
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


module clockMaster(input logic clk, output logic scriptclk, gameclk, bossclk);
    logic [23:0] scriptCount= 24'b100110001001011010000000;
    logic [23:0] scounter=0;
    logic [23:0] bossCount=24'b101111101011110000100000;
    logic [23:0] bcounter =0;
    logic [23:0] gcounter =0;
    logic [23:0] gameCount = 24'b100001101011110000100000;
    
    always_ff@(posedge clk)
    if(scounter==scriptCount) begin
    scriptclk<=1; scounter<=0;end
    else begin
    scriptclk<=0; scounter<=scounter+1; end
    
    always_ff@(posedge clk)
        if(gcounter==gameCount) begin
        gameclk<=1; gcounter<=0;end
        else begin
        gameclk<=0; gcounter<=gcounter+1; end
        
    always_ff@(posedge clk)
        if(bcounter==bossCount) begin
        bossclk<=1; bcounter<=0;end
        else begin
        bossclk<=0; bcounter<=bcounter+1; end    

endmodule
