`timescale 1ns / 1ps
module add(
    input [31:0] add_1,
    input [31:0] add_2,
    output [31:0] out_data
    );
    assign out_data=add_1+add_2;
endmodule