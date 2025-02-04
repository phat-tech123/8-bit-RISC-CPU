module controller(
	input wire clk;
	input wire [2:0] opcode;
	output reg jump;
	output reg skip;
 	output reg memWrite;
	output reg memRead;	
	output reg ACCwrite;
	output reg ALUToACC;
	output reg [1:0] ALU_OP;
	output reg regWrite;
);

always@(posedge clk) begin
	case(opcode)
		3'b000:
			jump 		<= 1'b0; 
			skip 		<= 1'b0;
			memWrite 	<= 1'b0;
			memRead 	<= 1'b0;
			ACCwrite 	<= 1'b0;
			ALUToACC 	<= 1'b0;
			ALU_OP 		<= 1'b0;
			regWrite 	<= 1'b0;
		3'b001:
			jump 		<= 1'b1;
			skip 		<= 1'b0;
			memWrite 	<= 1'b0;
			memRead 	<= 1'b0;
			ACCwrite 	<= 1'b0;
			ALUToACC 	<= 1'b0;
			ALU_OP 		<= 1'b0;
			regWrite 	<= 1'b0;
		3'b010:
			jump 		<= 1'b0;
			skip 		<= 1'b0;
			memWrite 	<= 1'b0;
			memRead 	<= 1'b1;
			ACCwrite 	<= 1'b1;
			ALUToACC 	<= 1'b1;
			ALU_OP 		<= 2'b01;
			regWrite 	<= 1'b1;
		3'b011:
			jump 		<= 1'b0;
			skip 		<= 1'b0;
			memWrite 	<= 1'b0;
			memRead 	<= 1'b1;
			ACCwrite 	<= 1'b1;
			ALUToACC 	<= 1'b1;
			ALU_OP 		<= 2'b10;
			regWrite 	<= 1'b1;
		3'b100:
			jump 		<= 1'b0;
			skip 		<= 1'b0;
			memWrite 	<= 1'b0;
			memRead 	<= 1'b1;
			ACCwrite 	<= 1'b1;
			ALUToACC 	<= 1'b1;
			ALU_OP 		<= 2'b11;
			regWrite 	<= 1'b1;
		3'b101:
			jump 		<= 1'b0;
			skip 		<= 1'b0;
			memWrite 	<= 1'b0;
			memRead 	<= 1'b1;
			ACCwrite 	<= 1'b1;
			ALUToACC 	<= 1'b0;
			ALU_OP 		<= 2'b00;
			regWrite 	<= 1'b1;
		3'b110:
			jump 		<= 1'b0;
			skip 		<= 1'b0;
			memWrite 	<= 1'b1;
			memRead 	<= 1'b0;
			ACCwrite 	<= 1'b0;
			ALUToACC 	<= 1'b0;
			ALU_OP 		<= 2'b00;
			regWrite 	<= 1'b0;
		3'b111:
			jump 		<= 1'b0;
			skip 		<= 1'b1;
			memWrite 	<= 1'b0;
			memRead 	<= 1'b0;
			ACCwrite 	<= 1'b0;
			ALUToACC 	<= 1'b0;
			ALU_OP 		<= 1'b0;
			regWrite 	<= 1'b0;
	endcase
end
endmodule
