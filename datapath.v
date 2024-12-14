`include "memory.v"
`include "IR.v"
`include "ACC.v"
`include "programCounter.v"
`include "controller.v"
`include "AddressMux.v"
`include "ALU.v"
`include "storage.v"

module Datapath_Unit(
	input wire clk,
	input wire rst,
	output reg [7:0] fpga_data
);

wire [4:0] address_in; 		//Address loaded to Program Counter
wire [4:0] address_out; 	//Address out from Program Counter
wire [4:0] instruction_address;	 
wire [4:0] data_address;
wire [4:0] out_address;
wire [4:0] skip_address;
wire [4:0] skip_data_address;

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

always@(posedge clk) begin
	fpga_data <= ACC_data;
end

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

Adder_1 Adder_1_u(
	.address(out_address),
	.next_address(instruction_address)
);

Adder_2 Adder_2_u(
	.address(address_out),
	.next_address(skip_address)
);

skip_data_mux skip_data_mux_u(
	.inA(skip_address),
	.inB(data_address),
	.skip_signal(skip_signal),
	.skip_data_address(skip_data_address)
);

storage storage_u(
	.clk(clk),
	.address(address_out),
	.opcode(opcode),
	.out_address(out_address)
);

// A
AddressMux AddressMux_u(
	.PC_addr(PC_addr),
	.PC_actve(PC_actve),
	.instruction_address(instruction_address),
	.data_address(skip_data_address),
	.address(address_in)
);

ALU ALU_u(
	.ALU_Op(ALU_Op),
	.inA(ACC_data),
	.inB(data),
	.isZero(isZero),
	.out(data_out)
);

skip_AND skip_AND_u(
	skip, 
	ACC_data,
	skip_signal
);



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


module skip_AND(
    input wire inA,
    input wire [7:0] inB,
    output wire out
);

    // Continuous assignment instead of always block
    assign out = inA && ~(|inB);

endmodule
