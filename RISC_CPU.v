`include "multiplexer.v"
`include "PC.v"
`include "Memory.v"
`include "InstructionRegister.v"
`include "ALU.v"
`include "ACC.v"
`include "controller.v"
module RICS_CPU #( 
    parameter OPCODE = 3,
    parameter WIDTH_REG = 8
)(
    input clk,
    input reset,
    output wire [WIDTH_REG-1:0] result,
    output wire [WIDTH_REG - OPCODE - 1:0] pcc,
    output HALT
);
    // Các tín hi?u k?t n?
    localparam WIDTH_ADDRESS_BIT = WIDTH_REG - OPCODE;
    
    wire [WIDTH_ADDRESS_BIT - 1:0] pc_out;
    wire [WIDTH_ADDRESS_BIT - 1:0] mux_out;
    wire [WIDTH_REG-1:0] mem_data;
    //wire [WIDTH_REG-1:0] data_in;
    wire [OPCODE-1:0] opcode;
    wire [WIDTH_ADDRESS_BIT - 1:0] operand;
    wire [WIDTH_REG-1:0] acc_out;
    wire [WIDTH_REG-1:0] alu_out;
    wire alu_zero;
    
    // Tín hi?u ?i?u khi?n
    wire sel;
    wire rd;
    wire ld_ir;
    wire halt;
    wire inc_pc;
    wire ld_ac;
    wire ld_pc;
    wire wr;
    wire data_e;
    wire [7:0] out;

    assign result = acc_out; 
    assign pcc = mux_out;

    // Giá tr? ??u vào PC
    AddressMux #(.WIDTH(WIDTH_ADDRESS_BIT)) addr_mux(
        .sel(sel),
        .A(pc_out),
        .B(operand),
        .Z(mux_out)
    );
    // Kh?i t?o các module
    ProgramCounter #(.WIDTH_ADDRESS_BIT(WIDTH_ADDRESS_BIT)) pc(
        .clk(clk),
        .reset(reset),
        .load(ld_pc),
        .inc(inc_pc),
        .data_in(mux_out),
        .data_out(pc_out)
    );
    
    Memory #(.WIDTH_REG(WIDTH_REG), .WIDTH_ADDRESS_BIT(WIDTH_ADDRESS_BIT)) memory(
        .clk(clk),
        .rd(rd),
        .wr(wr),
        .addr(mux_out),
        .data(mem_data)
    );
    InstructionRegister #(.WIDTH_REG(WIDTH_REG), .OPCODE(OPCODE)) ir(
        .clk(clk),
        .reset(reset),
        .load(ld_ir),
        .data_in(mem_data),
        .opcode(opcode),
        .operand(operand)
    );
    
    ALU #(.WIDTH_REG(WIDTH_REG), .OPCODE(OPCODE)) alu(
        .opcode(opcode),
        .inA(acc_out),
        .inB(mem_data),
        .out(alu_out),
        .is_zero(alu_zero)
    );
    
    Accumulator #(.WIDTH_REG(WIDTH_REG)) acc(
        .clk(clk),
        .reset(reset),
        .load(ld_ac),
        .data_in(alu_out),
        .data_out(acc_out)
    );
    Controller ctrl(
        .clk(clk),
        .reset(reset),
        .opcode(opcode),
        .is_zero(alu_zero),
        .sel(sel),
        .rd(rd),
        .ld_ir(ld_ir),
        .halt(halt),
        .inc_pc(inc_pc),
        .ld_ac(ld_ac),
        .ld_pc(ld_pc),
        .wr(wr),
        .data_e(data_e)
    );
    DataMux #(.WIDTH(WIDTH_REG)) bus(
        .sel(data_e),
        .A(acc_out),
        .Z(mem_data)
    );
    assign HALT = halt;
endmodule
