`timescale 1ns / 1ps

module cpu(
    input         clk,
    input         reset,
    input  [31:0] inst,
    input  [31:0] rdata,
    output [31:0] pc,
    output [31:0] DM_addr,
    output [31:0] DM_wdata,
    output        DM_CS,
    output        DM_R,
    output        DM_W
);
    
    wire PC_CLK;                     
    wire PC_ENA;                     
    wire M1_1, M2, M3_1,M3_2, M4_1,M4_2,M5,M6_1, M6_2;                        
    wire [3:0] ALUC;                 
    wire RF_W;                       
    wire RF_CLK;                     
    wire C_EXT16;                    
                              
    
    wire [31:0] ins_code;                 
    
    wire [31:0] ALU;               
    wire [31:0] PC;                
    wire [31:0] RF;                
    wire [31:0] Rs;                
    wire [31:0] Rt;                
    wire [31:0] IM;                
    wire [31:0] DM;                
    wire [31:0] Mux1_1;              
    wire [31:0] Mux1_2;              
    wire [31:0] Mux2;              
    wire [31:0] Mux3_1;              
    wire [31:0] Mux3_2;              
    wire [31:0] Mux4_1;                          
    wire [31:0] Mux4_2;                          
    wire [31:0] Mux5;                          
    wire [4:0]  Mux6_1;              
    wire [4:0]  Mux6_2;              
    wire [31:0] Mux7;              
    wire [31:0] Mux8;              
    wire [31:0] Mux9;              
    wire [31:0] Mux10;             
    wire        Mux11;             
                                      
    wire [31:0] EXT1;              
    wire [31:0] EXT5;              
    wire [31:0] EXT16;             
    wire [31:0] EXT18;             
    wire [31:0] ADD;               
    wire [31:0] ADD8;              
    wire [31:0] NPC;               
    wire [31:0] ii;
        
    wire zero;                       
    wire carry;                      
    wire negative;                   
    wire overflow; 
                   
    assign PC_ENA = 1;
    
    assign pc = PC;
    assign DM_addr = ALU;
    assign DM_wdata = Rt;
    
    instr_decode cpu_inst (.instr_in(inst), .instr_out(ins_code));
    controller cpu_control (.clk(clk), .z(zero), .i(ins_code), .PC_CLK(PC_CLK), 
        .IM_R(IM_R), .M1_1(M1_1), .M1_2(M1_2), .M2(M2), .M3_1(M3_1), .M3_2(M3_2), .M4_1(M4_1), .M4_2(M4_2),.M5(M5), .M6_1(M6_1),.M6_2(M6_2), 
        .ALUC(ALUC), .RF_W(RF_W), .RF_CLK(RF_CLK), .DM_w(DM_W), .DM_r(DM_R), .DM_cs(DM_CS), .C_EXT16(C_EXT16)
    );
    pcreg cpu_pc (.clk(PC_CLK), .rst(reset), .ena(PC_ENA),.data_in(Mux1_2), .data_out(PC));
    npc cpu_npc  (.in(PC), .out(NPC));
    alu cpu_alu (.a(Mux3_2), .b(Mux4_2),.aluc(ALUC), .r(ALU),.zero(zero), .carry(carry), .negative(negative), .overflow(overflow));
    II cpu_ii(.a(PC[31:28]),.b(inst[25:0]),.out_data(ii));
    mux cpu_mux1_1(.a(ii),.b(Mux5),.choice(M1_1),.out_data(Mux1_1));
    mux cpu_mux1_2(.a(Mux1_1),.b(Rs),.choice(M1_2),.out_data(Mux1_2));
    mux cpu_mux2(.a(rdata),.b(ALU),.choice(M2),.out_data(Mux2));
    mux cpu_mux3_1(.a(Rs),.b(EXT5),.choice(M3_1),.out_data(Mux3_1));
    mux cpu_mux3_2(.a(Mux3_1),.b(PC),.choice(M3_2),.out_data(Mux3_2));
    mux cpu_mux4_1(.a(Rt),.b(EXT16),.choice(M4_1),.out_data(Mux4_1));
    mux cpu_mux4_2(.a(Mux4_1),.b(32'd4),.choice(M4_2),.out_data(Mux4_2));
    mux cpu_mux5(.a(NPC),.b(ADD),.choice(M5),.out_data(Mux5));
    mux_5bits cpu_mux6_1(.a(inst[15:11]),.b(inst[20:16]),.choice(M6_1),.out_data(Mux6_1));
    mux_5bits cpu_mux6_2(.a(Mux6_1),.b(5'd31),.choice(M6_2),.out_data(Mux6_2));
    ext5 cpu_ext5(.a(inst[10:6]),.b(EXT5));
    ext16 cpu_ext16 (.a(inst[15:0]), .sext(C_EXT16), .b(EXT16));
    ext18 cpu_ext18(.a(inst[15:0]),.b(EXT18));
    add cpu_add(.add_1(EXT18),.add_2(NPC),.out_data(ADD));
    regfile cpu_ref(.clk(RF_CLK),.rst(reset), .we(RF_W),.Rsc(inst[25:21]), .Rtc(inst[20:16]), .Rdc(Mux6_2),.Rs(Rs), .Rt(Rt), .Rd(Mux2));
    
endmodule