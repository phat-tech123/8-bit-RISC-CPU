module ACC(
	input wire clk,
	input wire regWrite,
	input wire [7:0] in,
	output reg [7:0] out
);

always@(posedge clk) begin
	if(regWrite) begin
		out <= in;
	end
end

endmodule
