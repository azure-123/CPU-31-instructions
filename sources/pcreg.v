`timescale 1ns / 1ps
module pcreg(
    input clk,
    input rst,
    input ena,
    input [31:0] data_in,
    output [31:0] data_out
    );
    
    reg [31:0] data=32'b0;

    always @(posedge clk or posedge rst) 
    begin
        if(rst) 
        data<=32'h00400000;     
        else 
        begin
            if(ena) 
            data<=data_in;       
        end
    end
    
    assign data_out=data;
    
endmodule