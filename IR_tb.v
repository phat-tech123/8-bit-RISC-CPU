`timescale 1ns/1ps

module instructionRegister_tb;
reg clk;
reg [7:0] data;
wire [2:0] opcode;
wire [4:0] address;

instructionRegister u_instructionRegister(
	.clk(clk),
	.data(data),
	.opcode(opcode),
	.address(address)
);

initial begin
	$dumpfile("instructionRegister.vcd");
	$dumpvars(0, instructionRegister_tb);
end

initial begin
	data = 8'b00000000;
	#50;
	data = 8'b11000001;
	#50;
	data = 8'b11111111;
	#200;
end

initial begin
	clk = 0;
	forever begin
		clk = #25 ~clk;
	end
end

endmodule
