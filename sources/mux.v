`timescale 1ns / 1ps
module mux(
    input [31:0] a,
    input [31:0] b,
    input choice,
    output [31:0] out_data
    );
    assign out_data=(choice)?b:a;
endmodule
