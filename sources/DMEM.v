`timescale 1ns / 1ps
module DMEM(
    input clk,
    input ena,
    input write,
    input read,
    input [10:0] addr,
    input [31:0] wdata,
    output [31:0] rdata
);

    reg [31:0] data[0:31];
    
    always @ (negedge clk) 
    begin
        if (write && ena) 
        begin
            data[addr] <= wdata;
        end
    end
    
    assign rdata = (read && ena) ? data[addr] : 32'bz;
    
endmodule