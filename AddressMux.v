module AddressMux(
	input wire data_signal,
	input wire [4:0] instruction_address,
	input wire [4:0] data_address,
	output reg [4:0] address
);

always@(*) begin
	address = (data_signal == 1'b1) ? data_address : instruction_address;
end

endmodule
