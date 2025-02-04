module ACC(
	input wire clk,
	input wire ACCwrite,
	input wire [7:0] in,
	output reg [7:0] out
);

always@(posedge clk) begin
	if(ACCwrite)
		out <= in;
	else
		out <= out;
end

endmodule
