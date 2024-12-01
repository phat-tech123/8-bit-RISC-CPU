module controller(
	input wire [2:0] opcode;
	output reg write_en;
	output reg skip;
 	output reg regWrite;
	output reg ALUToACC;
	output reg branch;
	output reg [1:0] ALU_Op;
);

endmodule;
