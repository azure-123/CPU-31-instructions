`timescale 1ns / 1ps

module controller(
    input clk,
    input z,
    input [31:0] i,
    output PC_CLK,
    output IM_R,
    output M1_1,
    output M1_2,
    output M2,
    output M3_1,
    output M3_2,
    output M4_1,
    output M4_2,
    output M5,
    output M6_1,
    output M6_2,
    output [3:0] ALUC,
    output RF_W,
    output RF_CLK,
    output DM_w,
    output DM_r,
    output DM_cs,
    output C_EXT16
);
    assign _add  =i[0];
    assign _addu =i[1];
    assign _sub  =i[2];
    assign _subu =i[3];
    assign _and  =i[4];
    assign _or   =i[5];
    assign _xor  =i[6];
    assign _nor  =i[7];
    assign _slt  =i[8];
    assign _sltu =i[9];
    assign _sll  =i[10];
    assign _srl  =i[11];
    assign _sra  =i[12];
    assign _sllv =i[13];
    assign _srlv =i[14];
    assign _srav =i[15];
    assign _jr   =i[16];
    assign _addi =i[17];
    assign _addiu=i[18];
    assign _andi =i[19];
    assign _ori  =i[20];
    assign _xori =i[21];
    assign _lw   =i[22];
    assign _sw   =i[23];
    assign _beq  =i[24];
    assign _bne  =i[25];
    assign _slti =i[26];
    assign _sltiu=i[27];
    assign _lui  =i[28];
    assign _j    =i[29];
    assign _jal  =i[30];


    assign PC_CLK  = ~clk;
    assign IM_R    = 1;
    assign M1_1    = ~(_j |_jr |_jal);
    assign M1_2    =  _jr;
    assign M2      = ~_lw;
    assign M3_1    = _sll|_srl|_sra;//1
    assign M3_2    = _jal;
    assign M4_1    = _lui|_addi|_addiu|_andi|_ori|_xori|_lw|_sw|_slti|_sltiu;//0
    assign M4_2    = _jal;
    assign M5      =(_beq&z)|(_bne&~z);
    assign M6_1    = _lui|_addi|_addiu|_andi|_ori|_xori|_lw|_slti|_sltiu;//0
    assign M6_2    =_jal;
    assign ALUC[3] =_slt|_sltu|_sll|_srl|_sra|_sllv|_srlv|_srav|_lui|_slti|_sltiu;//1
    assign ALUC[2] =_and|_or|_xor|_nor|_sll|_srl|_sra|_sllv|_srlv|_srav|_andi|_ori|_xori;//1
    assign ALUC[1] =_add|_sub|_xor|_nor|_slt|_sltu|_sll|_sllv|_addi|_xori|_slti|_sltiu;//1
    assign ALUC[0] =_sub|_subu|_or|_nor|_slt|_srl|_srlv|_ori|_beq|_bne|_slti;//0
    assign RF_W=~(_jr|_sw|_beq|_bne|_j);//1
    assign RF_CLK  =~clk;
    assign DM_cs=_lw|_sw;
    assign DM_r=_lw;
    assign DM_w=_sw;
    assign C_EXT16 =~(_andi|_ori|_xori|_lui);//1

endmodule