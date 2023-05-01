`timescale 1ns / 1ps
module alu(
    input [31:0] a,
    input [31:0] b,
    input [3:0] aluc,
    output reg [31:0] r,
    output reg zero,
    output reg carry,
    output reg negative,
    output reg overflow
    );
    reg [32:0] tempu;
    reg [32:0] tempru;
    reg signed [32:0] tempr;
    reg signed [32:0] temp;
    
    always@(*)
    begin
    if(aluc==4'b0000)
    begin
    tempu<=a+b;
    r<=tempu[31:0];
    if(r==0)
        zero<=1;
    else
        zero<=0;
    carry<=tempu[32];
    negative<=r[31];
    overflow<=0;
    end
    
    else if(aluc==4'b0010)
    begin
    temp<=$signed(a)+$signed(b);
    r<=temp[31:0];
    if(r==0)
        zero<=1;
    else
        zero<=0;
    carry<=0;
    if($signed(r)<0)
        negative<=1;
    else
        negative<=0;
    if($signed(a)<0&&$signed(b)<0)
    begin
        if((-$signed(a))+(-$signed(b))>32'h7fffffff)
        overflow=1;
        else
        overflow=0;
    end
    else if($signed(a)>0&&$signed(b)>0)
    begin
        if($signed(a)+$signed(b)>32'h7fffffff)
            overflow=1;
            else
            overflow=0;
    end
    else
    overflow=0;
    end
    
    else if(aluc==4'b0001)
    begin
    tempu<=a-b;
    r<=tempu[31:0];
    if(r==0)
        zero<=1;
    else
        zero<=0;
    if(a<b)
        carry<=1;
    else
        carry<=0;
    negative=r[31];
    overflow<=0;
    end
    
    else if(aluc==4'b0011)
    begin
    tempu<=a-b;
    temp<=$signed(a)-$signed(b);
    r<=temp[31:0];
    if(r==0)
        zero<=1;
    else
        zero<=0;
    carry<=0;
    if($signed(r)<0)
        negative<=1;
    else
        negative<=0;
    if($signed(a)<0&&$signed(b)>0)
        begin
            if((-$signed(a))+$signed(b)>32'h7fffffff)
            overflow=1;
            else
            overflow=0;
        end
        else if($signed(a)>0&&$signed(b)<0)
        begin
            if($signed(a)+(-$signed(b))>32'h7fffffff)
                overflow=1;
                else
                overflow=0;
        end
        else
        overflow=0;
    end
    
    else if(aluc==4'b0100)
    begin
    r<=a&b;
    if(r==0)
        zero<=1;
    else
        zero<=0;
    carry<=0;
    negative<=r[31];
    overflow<=0;
    end
    
    else if(aluc==4'b0101)
    begin
    r<=a|b;
    if(r==0)
        zero<=1;
    else
        zero<=0;
    carry<=0;
    negative<=r[31];
    overflow<=0;
    end
    
    else if(aluc==4'b0110)
    begin
    r<=a^b;
    if(r==0)
        zero<=1;
    else
        zero<=0;
    carry<=0;
    negative<=r[31];
    overflow<=0;
    end

    else if(aluc==4'b0111)
    begin
    r<=~(a|b);
    if(r==0)
        zero<=1;
    else
        zero<=0;
    carry<=0;
    negative<=r[31];
    overflow<=0;
    end
    
    else if(aluc==4'b1000||aluc==4'b1001)
    begin
    r<={b[15:0],16'b0};
    if(r==0)
        zero<=1;
    else
        zero<=0;
    carry<=0;
    negative<=r[31];
    overflow<=0;
    end

    else if(aluc==4'b1011)
    begin
    r<=($signed(a)<$signed(b))? 1:0;
    if($signed(a)==$signed(b))
        zero<=1;
    else
        zero<=0;
    carry<=0;
    if($signed(a)<$signed(b))
        negative<=1;
    else
        negative<=0;
    overflow<=0;
    end

    else if(aluc==4'b1010)
    begin
    r<=(a<b)? 1:0;
    if(a==b)
        zero<=1;
    else
        zero<=0;
    carry<=(a<b)? 1:0;
    negative<=r[31];
    overflow<=0;
    end

    else if(aluc==4'b1100)
    begin
    if(a>0&&a<=32)
    carry<=b[a-1];
    else if(a==0)
    carry<=0;
    else
    carry<=b[31];
    r<=$signed(b)>>>a;
    if(r==0)
        zero<=1;
    else
        zero<=0;
    negative<=r[31];
    overflow<=0;
    end
    
    else if(aluc==4'b1110||aluc==4'b1111)
    begin
    tempu<=b<<a;
    r<=tempu[31:0];
    carry=tempu[32];
    if(r==0)
        zero<=1;
    else
        zero<=0;
    negative<=r[31];
    overflow<=0;
    end    
    
    else if(aluc==4'b1101)
    begin
    if(a>0&&a<=32)
    carry<=b[a-1];
    else if(a==0)
    carry<=0;
    else
    carry<=0;
    r<=b>>a;
    if(r==0)
        zero<=1;
    else
        zero<=0;
    negative<=r[31];
    overflow<=0;
    end
    
    end
endmodule
