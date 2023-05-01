`timescale 1ns / 1ps
module ext16 #(parameter WIDTH=16)(
    input [WIDTH-1:0] a,
    input sext,
    output [31:0] b
    );
    assign b=sext?{{(32-WIDTH){a[WIDTH-1]}},a}:{27'b0,a};
endmodule
