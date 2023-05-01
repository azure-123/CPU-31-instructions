`timescale 1ns / 1ps
module mux_5bits(
    input [4:0] a,
    input [4:0] b,
    input choice,
    output [4:0] out_data
    );
    assign out_data=(choice)?b:a;
endmodule
