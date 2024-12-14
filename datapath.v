`include "memory.v"
`include "IR.v"
`include "ACC.v"
`include "programCounter.v"
`include "controller.v"
`include "AddressMux.v"
`include "ALU.v"

module Datapath_Unit(
	input wire clk,
	input wire rst
);

wire [4:0] address_in; 		//Address loaded to Program Counter
wire [4:0] address_out; 	//Address out from Program Counter
wire [4:0] instruction_address;	 
wire [4:0] data_address;

wire [7:0] data;
wire [7:0] ACC_data;
wire [7:0] data_out;
wire [7:0] dataToACC;

wire isZero;

wire [2:0] opcode;
wire stop;
wire write_en;
wire skip;
wire regWrite;
wire ALUToACC;
wire PC_addr;
wire PC_actve;
wire [1:0] ALU_Op;

wire skip_signal; 

// Memory
memory memory_u(
	.clk(clk),
	.write_en(write_en),
	.address(address_out),
	.data(data)
);
assign data = (write_en) ? ACC_data : 8'bz;
// Register
instructionRegister IR_u(
	.clk(clk),
	.data(data),
	.opcode(opcode),
	.address(data_address)
);

ACC ACC_u(
	.clk(clk),
	.regWrite(regWrite),
	.in(dataToACC),
	.out(ACC_data)
);

// Controller
controller controller_u(
	.clk(clk),
	.opcode(opcode),
	.stop(stop),
	.write_en(write_en),
	.skip(skip),
	.regWrite(regWrite),
	.ALUToACC(ALUToACC),
	.PC_addr(PC_addr),
	.PC_actve(PC_actve),
	.ALU_Op(ALU_Op)
);

// Program Counter
PC PC_u(
	.clk(clk),
	.rst(rst),
	.stop(stop),
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
	.PC_addr(PC_addr),
	.PC_actve(PC_actve),
	.instruction_address(instruction_address),
	.data_address(data_address),
	.stayed_address(address_out),
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



dataMux dataMux_u(
	.ALU_data(data_out),
	.MEM_data(data),
	.ALUToACC(ALUToACC),
	.data_out(dataToACC)
);


endmodule

module dataMux(
    input wire [7:0] ALU_data,  
    input wire [7:0] MEM_data,   
    input wire ALUToACC,        
    output reg [7:0] data_out 
);

always @(*) begin
    if (ALUToACC)
        data_out = ALU_data;  
    else
        data_out = MEM_data; 
end

endmodule


