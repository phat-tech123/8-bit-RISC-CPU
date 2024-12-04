module controller(
	input wire clk;
	input wire [2:0] opcode;
	output reg write_en;
	output reg skip;
 	output reg regWrite;
	output reg ALUToACC;
	output reg branch;
	output reg [1:0] ALU_Op;
);

reg [2:0] counter;

always@(posedge clk) begin
	if(counter == 3'b0) begin
	case(opcode)
		3'b000:
			write_en <= 1'b0;
			skip <= 1'b1;
			regWrite <= 1'b0;
			ALUToACC <= 1'b0;
			branch <= 1'b0;
			ALU_Op <= 2'b00;
		3'b001:
			write_en <= 1'b0;
			skip <= 1'b1;
			regWrite <= 1'b0;
			ALUToACC <= 1'b0;
			branch <= 1'b0;
			ALU_Op <= 2'b00;
		3'b010:
			write_en <= 1'b0; 
			skip <= 1'b0;
			regWrite <= 1'b1;
			ALUToACC <= 1'b1;
			branch <= 1'b0;
			ALU_Op <= 2'b01;
		3'b011:
			write_en <= 1'b0; 
			skip <= 1'b0;
			regWrite <= 1'b1;
			ALUToACC <= 1'b1;
			branch <= 1'b0;
			ALU_Op <= 2'b10;
		3'b100:
			write_en <= 1'b0; 
			skip <= 1'b0;
			regWrite <= 1'b1;
			ALUToACC <= 1'b1;
			branch <= 1'b0;
			ALU_Op <= 2'b11;
		3'b101:
			write_en <= 1'b0;
			skip <= 1'b0;
			regWrite <= 1'b1;
			ALUToACC <= 1'b0; 
			branch <= 1'b0;
			ALU_Op <= 2'b00;
		3'b110:
			write_en <= 1'b1; 
			skip <= 1'b0;
			regWrite <= 1'b0;
			ALUToACC <= 1'b0;
			branch <= 1'b0;
			ALU_Op <= 2'b00;
		3'b111:
			write_en <= 1'b0; 
			skip <= 1'b0;
			regWrite <= 1'b0;
			ALUToACC <= 1'b0;
			branch <= 1'b1;
			ALU_Op <= 2'b00;
	end
end else begin
	counter <= counter - 1;
end
	
endmodule;
