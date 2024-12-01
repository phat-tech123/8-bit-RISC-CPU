module instructionRegister(
	input wire clk,
	input wire [7:0] data,
	output reg [2:0] opcode,
	output reg [4:0] address
);

always@(posedge clk) begin
	opcode <= data[7:5];
	address <= data[4:0];
end

endmodule
