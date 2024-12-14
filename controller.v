module controller(
    input wire clk,
    input wire [2:0] opcode,
    output reg nonAdd,
    output reg stop,
    output reg write_en,
    output reg skip,
    output reg regWrite,
    output reg ALUToACC,
    output reg PC_addr,
    output reg PC_actve,
    output reg [1:0] ALU_Op
);

reg [2:0] counter; 	// For Controller
reg [2:0] counter1; 	// For Accumulator Register
reg [1:0] counter2; 	// For PC_addr  
reg [1:0] counter3; 	// For PC_actve 

localparam HLT = 3'b000;
localparam SKZ = 3'b001;
localparam ADD = 3'b010;
localparam AND = 3'b011;
localparam XOR = 3'b100;
localparam LDA = 3'b101;
localparam STO = 3'b110;
localparam JMP = 3'b111;

// Initialize the counter1
initial begin
	stop      <= 1'b0;
	write_en  <= 1'b0;
	skip      <= 1'b0;
	regWrite  <= 1'b0;
	ALUToACC  <= 1'b0;
	PC_addr   <= 1'b0;
	PC_actve  <= 1'b0;
	ALU_Op    <= 2'b00;
	counter1  <= 2'b00;
	counter2  <= 2'b00;
	counter3  <= 2'b00;
	counter   <= 3'b000; 
end

always@(posedge clk) begin
	if(counter == 3'b000) begin
	case(opcode)
		HLT: begin
			stop 	 <= 	1'b1;
			write_en <= 	1'b0;
			skip 	 <= 	1'b0;
			regWrite <= 	1'b0;
			ALUToACC <= 	1'b0;
			PC_addr  <= 	1'b0;
			PC_actve <= 	1'b0;
			ALU_Op 	 <= 	2'b00;
			counter1 <= 	2'd0;
			counter2 <= 	2'd0;
			counter3 <= 	2'd0;
		end
		SKZ: begin
			stop 	 <= 	1'b0;
			write_en <= 	1'b0;
			skip 	 <= 	1'b1;
			regWrite <= 	1'b0;
			ALUToACC <= 	1'b0;
			PC_addr  <= 	1'b1;
			PC_actve <= 	1'b1;	
			ALU_Op 	 <= 	2'b00;
			counter1 <= 	2'd0;
			counter2 <= 	2'd0;
			counter3 <= 	2'd0;
			counter  <= 	2'd3;
		end
		ADD: begin
			stop 	 <= 	1'b0;
			write_en <= 	1'b0; 
			skip 	 <= 	1'b0;
			regWrite <= 	1'b1;
			ALUToACC <= 	1'b1;
			PC_addr  <= 	1'b1;
			PC_actve <= 	1'b1;
			ALU_Op 	 <= 	2'b01;
			counter1 <=   	2'd3;
			counter2 <= 	2'd2;
			counter3 <= 	2'd3;
			counter  <= 	3'd5;
		end
		AND: begin
			stop 	 <= 	1'b0;
			write_en <= 	1'b0; 
			skip 	 <= 	1'b0;
			regWrite <= 	1'b1;
			ALUToACC <= 	1'b1;
			PC_addr  <= 	2'b1;
			PC_actve <= 	1'b1;
			ALU_Op 	 <= 	2'b10;
			counter1 <=   	2'd3;
			counter2 <= 	2'd2;
			counter3 <= 	2'd3;
			counter  <= 	3'd5;
		end	
		XOR: begin
			stop 	 <= 	1'b0;
			write_en <= 	1'b0; 
			skip 	 <= 	1'b0;
			regWrite <= 	1'b1;
			ALUToACC <= 	1'b1;
			PC_addr  <= 	2'b1;
			PC_actve <= 	1'b1;
			ALU_Op 	 <= 	2'b11;
			counter1 <=   	2'd3;
			counter2 <= 	2'd2;
			counter3 <= 	2'd3;
			counter  <= 	3'd5;
		end
		LDA: begin
			nonAdd 	 <= 	1'b1;
			stop 	 <= 	1'b0;
			write_en <= 	1'b0;
			skip 	 <= 	1'b0;
			regWrite <= 	1'b1;
			ALUToACC <= 	1'b0; 
			PC_addr  <= 	2'b1;
			PC_actve <= 	1'b1;
			ALU_Op 	 <= 	2'b00;
			counter1 <=   	3'd4;
			counter2 <= 	2'd2;
			counter3 <= 	2'd3;
			counter  <= 	3'd5;
		end
		STO: begin
			stop 	 <= 	1'b0;
			write_en <= 	1'b1; 
			skip 	 <= 	1'b0;
			regWrite <= 	1'b0;
			ALUToACC <= 	1'b0;
			PC_addr  <= 	1'b1;
			PC_actve <= 	1'b1;
			ALU_Op 	 <= 	2'b01;
			counter1 <=   	2'd0;
			counter2 <= 	2'd1;
			counter3 <= 	2'd2;
		end
		JMP: begin
			stop 	 <= 	1'b0;
			write_en <= 	1'b0; 
			skip 	 <= 	1'b0;
			regWrite <= 	1'b0;
			ALUToACC <= 	1'b0;
			PC_addr  <= 	1'b1;
			PC_actve <=  	1'b1;
			ALU_Op 	 <= 	2'b00;
			counter1 <= 	2'd0; 
			counter2 <= 	2'd1;
			counter3 <= 	2'd1;
			counter  <= 	3'd3;
		end
	endcase
	end else begin
		counter = counter - 1;
	end
end

always@(negedge clk) begin
	if(counter1 == 2'd0) begin
		regWrite <= 1'b0;
		skip <= 1'b0;
	end else begin
		counter1 = counter1 - 1;
	end

	if(counter2 == 2'd0)begin
		PC_addr = 1'b0;
	end else begin
		counter2 = counter2 - 1;
	end

	if(counter3 == 2'd0) begin
		PC_actve = 1'b0;
	end else begin
		counter3 = counter3 - 1;
	end
end

endmodule

