`timescale 1ns / 1ps

module sccomp_dataflow(
    input clk_in,
    input reset,
    output [31:0] inst,
    output wire [31:0] pc
);

    wire dmw, dmr, dena;
    wire [31:0] wdata, rdata;
    wire [31:0] instr, dma;
    wire [10:0] dm_addr;
    wire [10:0] im_addr;

    IMEM imem(
        .addr(im_addr),
        .instr(instr)
    );
    
    DMEM dmem(
        .clk(clk_in), .ena(dena),
        .write(dmw), .read(dmr),
        .addr(dm_addr[10:0]), .wdata(wdata), .rdata(rdata)
    );
    
    cpu sccpu(
        .clk(clk_in), .reset(reset),
        .inst(instr), .rdata(rdata),
        .DM_CS(dena), .DM_R(dmr), .DM_W(dmw), .DM_addr(dma), .DM_wdata(wdata),
        .pc(pc)
    );
    assign inst = instr;   
    assign im_addr = (pc  - 32'h00400000) / 4;
    assign dm_addr = (dma - 32'h10010000) / 4; 
    
endmodule