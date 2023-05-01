`timescale 1ns / 1ps

module instr_decode(
    input [31:0] instr_in,
    output reg [31:0] instr_out
    );
    parameter _add  =32'b00000000000000000000000000000001;
    parameter _addu =32'b00000000000000000000000000000010;
    parameter _sub  =32'b00000000000000000000000000000100;
    parameter _subu =32'b00000000000000000000000000001000;
    parameter _and  =32'b00000000000000000000000000010000;
    parameter _or   =32'b00000000000000000000000000100000;
    parameter _xor  =32'b00000000000000000000000001000000;
    parameter _nor  =32'b00000000000000000000000010000000;
    parameter _slt  =32'b00000000000000000000000100000000;
    parameter _sltu =32'b00000000000000000000001000000000;
    parameter _sll  =32'b00000000000000000000010000000000;
    parameter _srl  =32'b00000000000000000000100000000000;
    parameter _sra  =32'b00000000000000000001000000000000;
    parameter _sllv =32'b00000000000000000010000000000000;
    parameter _srlv =32'b00000000000000000100000000000000;
    parameter _srav =32'b00000000000000001000000000000000;
    parameter _jr   =32'b00000000000000010000000000000000;
    parameter _addi =32'b00000000000000100000000000000000;
    parameter _addiu=32'b00000000000001000000000000000000;
    parameter _andi =32'b00000000000010000000000000000000;
    parameter _ori  =32'b00000000000100000000000000000000;
    parameter _xori =32'b00000000001000000000000000000000;
    parameter _lw   =32'b00000000010000000000000000000000;
    parameter _sw   =32'b00000000100000000000000000000000;
    parameter _beq  =32'b00000001000000000000000000000000;
    parameter _bne  =32'b00000010000000000000000000000000;
    parameter _slti =32'b00000100000000000000000000000000;
    parameter _sltiu=32'b00001000000000000000000000000000;
    parameter _lui  =32'b00010000000000000000000000000000;
    parameter _j    =32'b00100000000000000000000000000000;
    parameter _jal  =32'b01000000000000000000000000000000;
    
    always@(*)
    begin
        casex({instr_in[31:26],instr_in[5:0]})
            12'b000000_100000:instr_out<=_add;
            12'b000000_100001:instr_out<=_addu;
            12'b000000_100010:instr_out<=_sub;
            12'b000000_100011:instr_out<=_subu;
            12'b000000_100100:instr_out<=_and;
            12'b000000_100101:instr_out<=_or;
            12'b000000_100110:instr_out<=_xor;
            12'b000000_100111:instr_out<=_nor;
            12'b000000_101010:instr_out<=_slt;
            12'b000000_101011:instr_out<=_sltu;
            12'b000000_000000:instr_out<=_sll;
            12'b000000_000010:instr_out<=_srl;
            12'b000000_000011:instr_out<=_sra;
            12'b000000_000100:instr_out<=_sllv;
            12'b000000_000110:instr_out<=_srlv;
            12'b000000_000111:instr_out<=_srav;
            12'b000000_001000:instr_out<=_jr;
            12'b001000_??????:instr_out<=_addi;
            12'b001001_??????:instr_out<=_addiu;
            12'b001100_??????:instr_out<=_andi;
            12'b001101_??????:instr_out<=_ori;
            12'b001110_??????:instr_out<=_xori;
            12'b100011_??????:instr_out<=_lw;
            12'b101011_??????:instr_out<=_sw;
            12'b000100_??????:instr_out<=_beq;
            12'b000101_??????:instr_out<=_bne;
            12'b001010_??????:instr_out<=_slti;
            12'b001011_??????:instr_out<=_sltiu;
            12'b001111_??????:instr_out<=_lui;
            12'b000010_??????:instr_out<=_j;
            12'b000011_??????:instr_out<=_jal;
            default:instr_out<=32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
        endcase
    end
endmodule
