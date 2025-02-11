`include "ACC.v"
`include "PC.v"
`include "controller.v"
`include "ALU.v"
`include "multiplexer.v"
`include "DataMemory.v"
`include "InstructionMemory.v"

module CPU(
	input clk, rst
);
//Program Counter
wire [4:0] load_address;
wire [4:0] out_address;
wire [4:0] nextAddress;

//Instruction Memory
wire [4:0] address;
wire [7:0] instruction;
wire [2:0] opcode;

//ALU 
wire [7:0] data;
wire [7:0] MemoryData;
wire isZero;
wire [7:0] out;
wire [7:0] data_out;
wire [7:0] ACCdata;

//Controller
wire jump;
wire skip;
wire memWrite;
wire memRead;
wire write;
wire ALUto;
wire [1:0] ALU_OP;
wire Halt;


wire skipSignal;
//////////////// LAYOUT //////////////////
PC PC_u(
	.clk(clk),
	.rst(rst),
	.loaded_address(load_address),
	.address(out_address)
);

addressADD addressADD_u(
	.skipSignal(skipSignal),
	.address_in(out_address),
	.address_out(nextAddress)
);

addressMUX addressMUX_u(
	.jump(jump),
	.jumpAddress(address),
	.nextAddress(nextAddress),
	.address_out(load_address)
);


IM IM_u(
	.clk(clk),
	.Halt(Halt),
	.address(out_address),
	.instruction_out(instruction)
);

controller controller_u(
	.clk(clk),
	.opcode(opcode),
	.jump(jump),
	.skip(skip),
 	.memWrite(memWrite),
	.memRead(memRead),	
	.ACCwrite(ACCwrite),
	.ALUtoACC(ALUtoACC),
	.ALU_OP(ALU_OP),
	.Halt(Halt)
);

ALU ALU_u(
	.ALU_Op(ALU_OP),
	.inA(MemoryData),
	.inB(ACCdata),
	.isZero(isZero),
	.out(out)
);

ALUmux ALUmux(
	.ALUtoACC(ALUtoACC),
     	.ALUdata(out),
    	.MemoryData(MemoryData),
    	.data_out(data_out)
);

ACC ACC_u(
	.clk(clk),
	.ACCwrite(ACCwrite),
	.in(data_out),
	.out(ACCdata)
); 

DM DM_u(
	.clk(clk),
	.memWrite(memWrite),
	.memRead(memRead),
	.address(address),
	.data_in(ACCdata),
	.data_out(MemoryData)
);


assign opcode = instruction[7:5];
assign address = instruction[4:0];
assign skipSignal = skip & ~|ACCdata;


endmodule


