`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2016 09:23:23 PM
// Design Name: 
// Module Name: divide
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


module divide(input logic clk, output logic shcp, stcp,oe, int i, output logic f );
    
    
    logic [7:0] counter =0;
    
    always_ff@(posedge clk)
    counter <= counter+1;
    
    assign f = counter[7];
    
    always_ff@(negedge f)
    if(i==410)
    i<=1;
    else
    i <= i+1;
    
    always_ff@(negedge clk)
    if(i<28)
    begin
    shcp<=f;
    stcp<=~f;
    end
    else
    begin
    shcp<=0;
    stcp<=1;
    end
    
    
    always_ff@(posedge f)
        if(i>28 && i<409)
        oe <= 0;
        else
        oe<= 1;
        
        
    /*always_ff @(posedge clk)
        if(i==15999)
        begin
        i<=0;
        shcp<=1;
        end
        else
        begin
        i++;
        shcp<=0;
        end
    
        always_ff @(posedge shcp)
            if(j==23)
            begin
            j<=0;
            stcp<=1;
            end
            else
            begin
            j++;
            stcp<=0;
            end*/
endmodule
