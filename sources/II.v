`timescale 1ns / 1ps

module II(
    input [3:0] a,
    input [25:0] b,
    output [31:0] out_data
);

    assign out_data = {a, b<<2};
    
endmodule