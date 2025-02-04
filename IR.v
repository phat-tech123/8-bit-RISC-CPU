module instructionRegister(
	input wire clk,
	input wire [7:0] instruction,
	input wire [7:0] data_in,
	output reg [7:0] data_out
);

reg [7:0] DATA_1;
reg [7:0] DATA_2;
reg [7:0] TEMP;

initial begin
	DATA_1 	<= 8'b00000000;
	DATA_2 	<= 8'b11111111;
	TEMP 	<= 8'b10101010; 	
end

always@(posedge clk) begin
	if()	
end
endmodule
