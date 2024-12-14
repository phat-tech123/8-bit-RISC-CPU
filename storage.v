module storage(
	input wire clk,
	input wire [4:0] address,
	input wire [2:0] opcode,
	output reg [4:0] out_address
);

reg [2:0] counter;
reg [4:0] out;
reg [4:0] out1;
initial begin
	counter <= 3'd0;
end

always@(posedge clk) begin
	if(counter == 3'd0) begin
		out <= address;
		case(opcode)
			3'b000: counter = 3'd0;
			3'b001: counter = 3'd3;
			3'b010: counter = 3'd5;
			3'b011: counter = 3'd5;
			3'b100: counter = 3'd5;
			3'b101: counter = 3'd5;
			3'b110: counter = 3'd4;
			3'b111: counter = 3'd3;
		endcase
	end else begin
		counter <= counter - 1;
	end
end

always@(posedge clk) begin
	out1 <= out;
	out_address <= out1;
end
endmodule
