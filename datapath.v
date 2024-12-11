`include "memory.v"
`include "IR.v"
`include "ACC.v"
`include "ProgramCounter.v"
`include "controller.v"
`include "AddressMux.v"
`include "ALU.v"

module Datapath_Unit(
	input wire clk,
	input wire rst,
);

reg  [4:0] address_in; 		//Address loaded to Program Counter
wire [4:0] address_out; 	//Address out from Program Counter
wire [4:0] address; 		//Address out from Instruction Register
wire [4:0] instruction_address;	//Next Address 

wire [7:0] data;
wire [7:0] ACC_data;
wire [7:0] data_out;
wire isZero;

wire opcode;
wire write_en;
wire skip;
wire regWrite;
wire ALUToACC;
wire branch;
wire [1:0] ALU_Op;

wire skip_signal; 


initial begin 
	address_in = 5'b0;
end

// Memory
memory memory_u(
	.clk(clk),
	.write_en(write_en),
	.address(address_out),
	.data(data)
);

// Register
IR IR_u(
	.clk(clk),
	.data(data),
	.opcode(opcode),
	.address(address)
);

ACC ACC_u(
	.clk(clk),
	.regWrite(regWrite),
	.in(),
	.out()
);

// Controller
controller controller_u(
	.clk(clk),
	.opcode(opcode),
	.opcode(opcode),
	.write_en(write_en),
	.skip(skip),
	.regWrite(regWrite),
	.ALUToACC(ALUToACC),
	.branch(branch),
	.ALU_Op(ALU_Op)
);

// Program Counter
PC PC_u(
	.clk(clk),
	.rst(rst),
	.loaded_address(address_in),
	.address(address_out)
);
ADD_Mux ADD_Mux_u(
	.skip_signal(skip_signal),
	.address(address_out),
	.next_address(instruction_address)
);

// A
AddressMux AddressMux_u(
	.data_signal(branch),
	.instruction_address(instruction_address),
	.data_address(address),
	.address(address_in)
);

ALU ALU_u(
	.ALU_Op(ALU_Op),
	.inA(ACC_data),
	.inB(data),
	.isZero(isZero),
	.out(data_out)
);

and and_u(skip_signal, skip, isZero);



endmodule

