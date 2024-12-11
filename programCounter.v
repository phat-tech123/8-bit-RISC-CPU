module PC(
	input wire clk, rst,
	input wire [4:0] loaded_address,
	output reg [4:0] address
);

always@(posedge clk or posedge rst) begin
	if(rst) 
		address <= 5'b00000;
	else
		address <= loaded_address;
end
endmodule

module ADD_Mux(
	input wire skip_signal,
	input wire [4:0] address,
	output wire [4:0] next_address
);
always@(*) begin
	if(skip_signal)
		next_address = address + 5'd2;
	else
		next_address = address + 5'd1;
end

endmodule
