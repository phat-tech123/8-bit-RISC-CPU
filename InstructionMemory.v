module IM(
	clk,
	address,
	instruction_out
);
parameter DATA_WIDTH = 8;
parameter ADDRESS_WIDTH = 5;
parameter MEMORY_DEPTH = 32;

input wire clk;
input wire [ADDRESS_WIDTH-1:0] address;
output reg [DATA_WIDTH-1:0] instruction_out;

reg [DATA_WIDTH-1:0] instructions[MEMORY_DEPTH-1:0]; 

initial begin
        $readmemb("./instruction.mem", instructions, 0, 31);
end

always@(posedge clk) begin
	instruction_out = instructions[address];
end

endmodule

