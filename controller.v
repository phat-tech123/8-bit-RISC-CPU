module controller(
	input wire clk,
	input wire [2:0] opcode,
	output reg jump,
	output reg skip,
 	output reg memWrite,
	output reg memRead,	
	output reg ACCwrite,
	output reg ALUToACC,
	output reg [1:0] ALU_OP,
	output reg regWrite,
	output reg Halt
);

localparam HLT = 3'b000;
localparam SKZ = 3'b001;
localparam ADD = 3'b010;
localparam AND = 3'b011;
localparam XOR = 3'b100;
localparam LDA = 3'b101;
localparam STO = 3'b110;
localparam JMP = 3'b111;

always@(posedge clk) begin
	case(opcode)
		HLT: begin
			jump 		<= 1'b0; 
			skip 		<= 1'b0;
			memWrite 	<= 1'b0;
			memRead 	<= 1'b0;
			ACCwrite 	<= 1'b0;
			ALUToACC 	<= 1'b0;
			ALU_OP 		<= 2'b00;
			regWrite 	<= 1'b0;
			Halt 		<= 1'b1;
		end
		SKZ: begin
			jump 		<= 1'b1;
			skip 		<= 1'b0;
			memWrite 	<= 1'b0;
			memRead 	<= 1'b0;
			ACCwrite 	<= 1'b0;
			ALUToACC 	<= 1'b0;
			ALU_OP 		<= 2'b00;
			regWrite 	<= 1'b0;
			Halt 		<= 1'b0;
		end
		ADD: begin
			jump 		<= 1'b0;
			skip 		<= 1'b0;
			memWrite 	<= 1'b0;
			memRead 	<= 1'b1;
			ACCwrite 	<= 1'b1;
			ALUToACC 	<= 1'b1;
			ALU_OP 		<= 2'b01;
			regWrite 	<= 1'b1;
			Halt 		<= 1'b0;
		end
		AND: begin
			jump 		<= 1'b0;
			skip 		<= 1'b0;
			memWrite 	<= 1'b0;
			memRead 	<= 1'b1;
			ACCwrite 	<= 1'b1;
			ALUToACC 	<= 1'b1;
			ALU_OP 		<= 2'b10;
			regWrite 	<= 1'b1;
			Halt 		<= 1'b0;
		end
		XOR: begin
			jump 		<= 1'b0;
			skip 		<= 1'b0;
			memWrite 	<= 1'b0;
			memRead 	<= 1'b1;
			ACCwrite 	<= 1'b1;
			ALUToACC 	<= 1'b1;
			ALU_OP 		<= 2'b11;
			regWrite 	<= 1'b1;
			Halt 		<= 1'b0;
		end
		LDA: begin
			jump 		<= 1'b0;
			skip 		<= 1'b0;
			memWrite 	<= 1'b0;
			memRead 	<= 1'b1;
			ACCwrite 	<= 1'b1;
			ALUToACC 	<= 1'b0;
			ALU_OP 		<= 2'b00;
			regWrite 	<= 1'b1;
			Halt 		<= 1'b0;
		end
		STO: begin
			jump 		<= 1'b0;
			skip 		<= 1'b0;
			memWrite 	<= 1'b1;
			memRead 	<= 1'b0;
			ACCwrite 	<= 1'b0;
			ALUToACC 	<= 1'b0;
			ALU_OP 		<= 2'b00;
			regWrite 	<= 1'b0;
			Halt 		<= 1'b0;
		end
		JMP: begin
			jump 		<= 1'b0;
			skip 		<= 1'b1;
			memWrite 	<= 1'b0;
			memRead 	<= 1'b0;
			ACCwrite 	<= 1'b0;
			ALUToACC 	<= 1'b0;
			ALU_OP 		<= 2'b00;
			regWrite 	<= 1'b0;
			Halt 		<= 1'b0;

		end
	endcase
end
endmodule
