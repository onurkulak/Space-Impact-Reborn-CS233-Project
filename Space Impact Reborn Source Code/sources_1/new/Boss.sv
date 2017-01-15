`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2016 12:21:53 PM
// Design Name: 
// Module Name: Boss
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


module Boss(input logic clk, rst, pause, alev, input logic [2:0] inp, output logic lose, output logic[1:0] timeLeft, health, output logic [7:0][23:0] outp);
    
    logic [2:0] r= 4;logic [2:0] g=2;logic [2:0] b=1;logic [2:0] p=5;logic [2:0] y=7;logic [2:0] c=3;logic [2:0] v=0;logic [2:0] w=6; 
    logic [7:0][23:0] next1, next2, next3, next4, trueNext;
    logic[2:0] player, bossPlace;
    logic [4:0] turn=0;
    logic loseLike=0;
    logic[5:0] pseudo_random;
    logic trigger;
    
    int letime=39;
    assign timeLeft=letime/10;
    always_ff@(posedge turn[4])
    if(!rst&&!pause)
            letime--;
            
    
    
    logic [2:0][5:0]boss;
    assign boss[2]={r,r};
    assign boss[1]={v,p};
    assign boss[0]={r,r};
    
    logic hit=0;
    
    always_ff@(posedge clk)
    if(rst) health<=3;
    else if(!pause&&hit&&!(turn%5==0||turn%5==3))
    health<=health-1;
    else health<=health;
    
    
    always_ff@(negedge clk) begin
    bossPlace=0; player=0;
        for(int i=0; i<7; i++)
            if(outp[i][2:0]==p)begin
                bossPlace=i;break; end
        for(int i=0; i<7; i++)
            if(outp[i][23:21]==b)begin
                player=i;break; end
    end
    
    
    xor(trigger, inp[2] ,inp[1], inp[0]);
    always_ff@(negedge clk)
        if(!trigger)
        if(pseudo_random!=41)pseudo_random<=pseudo_random+1;
        else  pseudo_random<=0;
    
    always_ff@(negedge clk)
        if(pause) 
        turn<=turn;
        else
        if(turn==19)
        turn<=0; 
        else 
        turn<=turn+1;
    
    always_comb
        if(turn==0)
        trueNext=next3;
        else if(turn%5==3)
        trueNext=next2;
        else if(turn%5==0)
        trueNext=next4;
        else trueNext=next1;
    
    always_comb
        if((loseLike==1||timeLeft==0)&&turn%5==4)
         lose=1;
         else lose=0;
         
         
    always_ff@(posedge clk)
    if(rst)
        begin
        outp[7]={g,g,g,v,v,r,r,r};
        for(int i = 0; i<7;i++)
            for(int j=0; j<24; j++)
                outp[i][j]=0;
        outp[1][23:21]=b;
        outp[5][5:0]=boss[2];
        outp[4][5:0]=boss[1];
        outp[3][5:0]=boss[0]; 
        end       
    else if (pause)
        outp<=outp;
    else
        outp<= trueNext;
        
        
        
    always_comb
    begin
    next3=outp;
        if(pseudo_random%2==0)begin
            if(bossPlace!=5)
                begin
                next3[bossPlace+2][5:0]=boss[2];
                next3[bossPlace+1][5:0]=boss[1];
                next3[bossPlace][5:0]=boss[0];
                next3[bossPlace-1][5:0]={v,v};
                end end
           else if(bossPlace!=1)
                begin
                next3[bossPlace-2][5:0]=boss[0];
                next3[bossPlace-1][5:0]=boss[1];
                next3[bossPlace][5:0]=boss[2];
                next3[bossPlace+1][5:0]={v,v};
                end
    case(pseudo_random%21)
    0:begin next3[0][8:6]=w; next3[1][8:6]=w; if(alev) next3[3][8:6]=w; end
    1:begin next3[0][8:6]=w; next3[2][8:6]=w; if(alev)next3[5][8:6]=w;end
    12:begin next3[0][8:6]=w; next3[3][8:6]=w;if(alev) next3[4][8:6]=w;end
    3:begin next3[0][8:6]=w; next3[5][8:6]=w;if(alev) next3[3][8:6]=w;end
    14:begin next3[0][8:6]=w; next3[4][8:6]=w; if(alev)next3[2][8:6]=w;end
    5:begin next3[0][8:6]=w; next3[6][8:6]=w;if(alev) next3[2][8:6]=w;end
    16:begin next3[1][8:6]=w; next3[2][8:6]=w; if(alev)next3[4][8:6]=w;end
    7:begin next3[1][8:6]=w; next3[3][8:6]=w; if(alev)next3[5][8:6]=w;end 
    18:begin next3[1][8:6]=w; next3[4][8:6]=w; if(alev)next3[2][8:6]=w;end 
    9:begin next3[1][8:6]=w; next3[5][8:6]=w;if(alev) next3[3][8:6]=w;end 
    10:begin next3[1][8:6]=w; next3[6][8:6]=w; if(alev)next3[5][8:6]=w;end
    11:begin next3[2][8:6]=w; next3[3][8:6]=w;if(alev) next3[4][8:6]=w;end
    2:begin next3[2][8:6]=w; next3[4][8:6]=w; if(alev)next3[5][8:6]=w;end
    13:begin next3[2][8:6]=w; next3[5][8:6]=w; if(alev)next3[3][8:6]=w;end
    4:begin next3[2][8:6]=w; next3[6][8:6]=w; if(alev)next3[4][8:6]=w;end
    15:begin next3[3][8:6]=w; next3[4][8:6]=w; if(alev)next3[2][8:6]=w;end
    6:begin next3[3][8:6]=w; next3[5][8:6]=w;if(alev) next3[4][8:6]=w;end
    17:begin next3[3][8:6]=w; next3[6][8:6]=w; if(alev)next3[2][8:6]=w;end
    8:begin next3[4][8:6]=w; next3[5][8:6]=w; if(alev)next3[3][8:6]=w;end
    19:begin next3[4][8:6]=w; next3[6][8:6]=w; if(alev)next3[5][8:6]=w;end
    20:begin next3[5][8:6]=w; next3[6][8:6]=w;if(alev) next3[2][8:6]=w;end
    default: begin next3[5][8:6]=w; next3[6][8:6]=w; if(alev)next3[2][8:6]=w; end
    endcase
    
    end
    
    //00shoot 01down 10up
    always_comb 
    begin 
    next2=outp;
    case(inp)
    0:if(!(next2[player][20:18]==w)) next2[player][20:18]=c;
    1:if(player!=0) begin next2[player-1][23:21]=b;next2[player][23:21]=v;end
    2:if(player!=6) begin next2[player+1][23:21]=b;next2[player][23:21]=v;end
    default:begin end
    endcase
    end
    
    always_comb
    begin
    next1=outp;
    hit=0;
    for(int i=0; i<7; i++)
        if(outp[i][5:3]==c&&outp[i][2:0]==p)begin
        hit=1; 
        next1[7][health*3-3]=0;
        next1[7][health*3-2]=0;
        next1[7][health*3-1]=0; 
        break; end
        
    for(int j=0; j<7; j++)
       for(int i=0; i<7; i++)    
         if(outp[i][j*3+2]==c[2]&&outp[i][j*3+1]==c[1]&&outp[i][j*3]==c[0]) begin

            next1[i][j*3+2]=v[2];
             next1[i][j*3+1]=v[1];
             next1[i][j*3]=v[0];             
             if(!(j==0||!(outp[i][j*3-3]==0&&outp[i][j*3-2]==0&&outp[i][j*3-1]==0)))
               begin
               next1[i][j*3-1]=c[2];
                next1[i][j*3-2]=c[1];
                next1[i][j*3-3]=c[0];                
                 end        
                 end
    end  
    
    always_comb 
    begin
    next4=outp;
    loseLike=0;
    next4[7][21-3*timeLeft+2]=v[2];
    next4[7][21-3*timeLeft+1]=v[1];
    next4[7][21-3*timeLeft]=v[0];
    if(outp[player][20:18]==w)
        loseLike=1;
    for(int i=0; i<7; i++)
        for(int j=21; j>5;j=j-3)
            if(outp[i][j+2]==w[2]&&outp[i][j+1]==w[1]&&outp[i][j]==w[0])
                begin
                if(j!=21)begin
                    next4[i][j+5]=w[2];
                    next4[i][j+4]=w[1];
                    next4[i][j+3]=w[0];
                    end
              next4[i][j+2]=v[2];
              next4[i][j+1]=v[2];
              next4[i][j]=v[2];
              end            
    end    
    
                
endmodule
