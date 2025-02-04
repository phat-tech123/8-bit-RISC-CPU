module IM(
	clk,
	Halt,
	address,
	instruction_out
);
parameter DATA_WIDTH = 8;
parameter ADDRESS_WIDTH = 5;
parameter MEMORY_DEPTH = 32;

input wire clk, Halt;
input wire [ADDRESS_WIDTH-1:0] address;
output reg [DATA_WIDTH-1:0] instruction_out;

reg [DATA_WIDTH-1:0] instructions[MEMORY_DEPTH-1:0]; 
reg hltSignal;

initial begin
        $readmemb("./instruction.mem", instructions, 0, 31);
end

initial begin
	hltSignal = 1'b0;
end

always@(posedge clk) begin
	if(Halt == 1'b1)
		hltSignal = 1'b1;
end

always@(posedge clk) begin
	if(!hltSignal)
		instruction_out = instructions[address];
	else
		instruction_out = instruction_out;
end

endmodule

