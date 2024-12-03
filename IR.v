module instructionRegister(
	input wire clk,
	input wire [7:0] data,
	output reg [2:0] opcode,
	output reg [4:0] address
);

reg [2:0] counter;

initial begin 
	counter = 3'd0;
end

always@(posedge clk) begin
	if(counter == 0) begin
		opcode <= data[7:5];
		address <= data[4:0];
		case(data[7:5])
			3'b010: counter <= 3'd5;
			3'b011: counter <= 3'd5;
			3'b100: counter <= 3'd5;
			3'b101: counter <= 3'd5;
			3'b110: counter <= 3'd4;
			default: counter <= 3'd3;
		endcase
	end else
		counter <= counter - 1;
end

endmodule
