`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2016 09:27:38 AM
// Design Name: 
// Module Name: theGame
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


module theGame(input clk, rst, pause, input logic [2:0] cnt, output logic [7:0][23:0] outp, output logic win, lose, output logic[5:0] killCount);
    
    logic [2:0] r= 4;logic [2:0] g=2;logic [2:0] b=1;logic [2:0] p=5;logic [2:0] w=7;logic [2:0] c=3;logic [2:0] v=0;logic [2:0] y=6; 
    logic [7:0][23:0] next1, next2, next3, next4, trueNext; //= {8{g}, 8{v},8{v},b,7{v},8{v},8{v},8{v},8{g}};
    logic[2:0] player; logic[1:0] special;
    logic [4:0] turn=0;
    logic loseLike;
    logic[2:0] pseudo_random;
    logic trigger;
    logic [1:0] alevlimod; 
    assign alevlimod[1]=killCount>25;
    assign alevlimod[0]=(killCount>10||killCount>40)&&!(killCount>10&&killCount<40);
    
    xor(trigger, cnt[2], cnt[1], cnt[0]);
    
    always_ff@(negedge clk)
    if(trigger)
    if(pseudo_random!=6)pseudo_random<=pseudo_random+1;
    else  pseudo_random<=1;
    
    always_ff@(posedge clk)
    if(turn%6==4)
    if(cnt[0]&&cnt[1]&&special!=2)
    special++;
    else
    special<=0;
    else special<=special;
    
    always_comb
    if(turn==0) 
    trueNext=next3;
    else if(turn%6==1)
    trueNext=next2;
    else if(turn%8==7)
    trueNext=next4;
    else  
    trueNext=next1;
    
    always_comb
    if(loseLike==1&&turn%8==6)
    lose=1;
    else lose=0; 
   
    
    always_ff@(negedge clk)
    if(rst) killCount<=0;
    else
    if(pause) begin
    killCount <= killCount;
    turn<=turn;
    end
    else
    if(turn==23)begin
    turn<=0; 
    if(killCount<50) killCount<=killCount+1; else killCount <=killCount; end
    else begin turn<=turn+1; killCount <=killCount; end
    
    assign win = killCount>=50;
    
    always_ff@(posedge clk)
    if(rst)
    begin
        for(int i=1; i<7 ;i++)
        for(int j=0; j<24; j++)
            outp[i][j]=0;
        
        
        for(int j=0; j<24; j=j+3)
           outp[0][j]=0;
        for(int j=1; j<24; j=j+3)
           outp[0][j]=1;
        for(int j=2; j<24; j=j+3)
           outp[0][j]=0;
           
        for(int j=0; j<24; j=j+3)
            outp[7][j]=0;
        for(int j=1; j<24; j=j+3)
            outp[7][j]=1;
        for(int j=2; j<24; j=j+3)
            outp[7][j]=0;        
            
        outp [4][23:21]=b;
    end
    else if (pause)
    outp<=outp;
    else
    outp<= trueNext;
    
    
    always_comb
    begin 
    next1=outp;
    next1[7]=outp[7]<<3;
    next1[7][2:0]=outp[7][23:21];
    next1[0]=outp[0]<<3;
    next1[0][2:0]=outp[0][23:21];
    for(int i = 6; i>0; i--)
        for(int j = 0; j<21;j=j+3)
            if(outp[i][j+2]==c[2]&&outp[i][j+1]==c[1]&&outp[i][j]==c[0])
                begin
                next1[i][j+2]=v[2];
                next1[i][j+1]=v[1];
                next1[i][j]=v[0];
                if(!j==0)
                if (outp[i][j-1]==r[2]&&outp[i][j-2]==r[1]&&outp[i][j-3]==r[0])
                begin
                   next1[i][j-1]=p[2];
                   next1[i][j-2]=p[1];
                   next1[i][j-3]=p[0];
                end
               else if (outp[i][j-1]==p[2]&&outp[i][j-2]==p[1]&&outp[i][j-3]==p[0])
               begin
                       next1[i][j-1]=v[2];
                       next1[i][j-2]=v[1];
                       next1[i][j-3]=v[0];
               end  
                else begin
                    next1[i][j-1]=c[2];
                    next1[i][j-2]=c[1];
                    next1[i][j-3]=c[0];
                end
                end
    end
    
    always_comb
    begin
    next3=outp;
    case(alevlimod)
    3:begin next3[7]=24'b010_000_010_000_010_000_010_000; next3[0]=24'b010_000_010_000_010_000_010_000; end
    2: begin next3[7]=24'b010_010_010_000_010_010_010_000; next3[0]=24'b010_010_010_000_010_010_010_000; end
    1: begin next3[7]=24'b010_010_010_010_010_010_010_000; next3[0]=24'b010_010_010_010_010_010_010_000; end
    default: begin next3[7]=24'b010_010_010_010_010_010_010_010; next3[0]=24'b010_010_010_010_010_010_010_010; end
    endcase
    if(pseudo_random!=0&&pseudo_random!=7)
    next3[pseudo_random][2:0]=r;
    else next3[3][2:0]=r;
    end
    
    
    always_ff@(negedge clk)
    begin player=0;
    for(int i=1; i<7;i++)
        if(outp[i][23:21]==b)
           player=i;
    end       
    //00=shoot 01=down 10=up 11=special
    always_comb
    begin
    next2=outp;
    case(cnt)
    0: if(outp[player][20:18]==r)
        next2[player][20:18]=v;
        else if(outp[player][17:15]==r) begin
        next2[player][20:18]=c;
        next2[player][17:15]=p; end
        else begin next2[player][20:18]=c;
        next2[player][17:15]=c;
        end
    1: if(player!=1)begin
        next2[player-1][23:21]=b;
        next2[player][23:21]=v;
        end
    2: if(player!=6)begin
        next2[player+1][23:21]=b;
        next2[player][23:21]=v;  
        end
    3:if(special==2)
    begin 
        next2[player][20:6]=15'b111_111_111_111_111;
    if(player!=6)
        next2[player+1][20:6]=15'b111_111_111_111_111;
    if(player!=1)
        next2[player-1][20:6]=15'b111_111_111_111_111;   
    end    
            
    default:begin end
    endcase
    end
    
     always_comb 
       begin
       loseLike=0;
       next4=outp;
       for(int i=1; i<7; i++) 
           if(outp[i][20:18]==r) begin
               loseLike=1;
               next4[i][20:18]=v;
               break;
               end
       
       for(int i=1; i<7; i++) begin
           for(int j=15; j>-1; j=j-3)
               if(outp[i][j+2]==r[2]&&outp[i][j+1]==r[1]&&outp[i][j]==r[0]&&!(outp[i][j+5]==c[2]&&outp[i][j+4]==c[1]&&outp[i][j+3]==c[0]))
                    begin
                    next4[i][j+5]=r[2]; 
                    next4[i][j+4]=r[1];
                    next4[i][j+3]=r[0];
                    next4[i][j+2]=v[2];
                    next4[i][j+1]=v[1];
                    next4[i][j+0]=v[0];
                    end
              end
      for(int i=1; i<7; i++) 
            for(int j=6; j<19; j=j+3)
                if(outp[i][j+2]==w[2]&&outp[i][j+1]==w[1]&&outp[i][j]==w[0])
                    begin
                       next4[i][j+2]=v[2];
                       next4[i][j+1]=v[1];
                       next4[i][j+0]=v[0];            
                  end        
       end  
                    
endmodule
