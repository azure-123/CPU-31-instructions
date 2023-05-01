`timescale 1ns / 1ps
module ext5 #(parameter WIDTH=5)(
    input [WIDTH-1:0] a,
    output [31:0] b
    );
    assign b={{(32-WIDTH){0}},a};
endmodule
