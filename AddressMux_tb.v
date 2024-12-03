`timescale 1ns/1ps
module AddressMux_tb;
reg clk, data_signal;
reg [4:0] data_address;
reg [4:0] instruction_address;
wire [4:0] address;

AddressMux u_AddressMux(
	.data_signal(data_signal),
	.instruction_address(instruction_address),
	.data_address(data_address),
	.address(address)
);

initial begin
	$dumpfile("AddressMux.vcd");
	$dumpvars(0, AddressMux_tb);
end
initial begin
	clk = 0;
	data_signal = 1'b0;
	data_address = 5'b00111;
	instruction_address = 5'b00000;
	#20
	data_signal = 1'b1;
	#20
	data_signal = 1'b0;
	#300
	$stop;
end

initial begin 
	forever begin
	clk = #25 ~clk;
	end
end


endmodule
