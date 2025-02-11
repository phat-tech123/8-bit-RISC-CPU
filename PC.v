module PC(
    input wire clk, 
    input wire rst, 
    input wire [4:0] loaded_address, 
    output reg [4:0] address
);

reg counter;
initial begin
	counter <= 1'b1;
	address <= 5'd0;
end

always @(posedge clk or posedge rst) begin
	if(rst)
		address <= 5'd0; 
	else if(counter == 1'b0) begin
		address <= loaded_address; 
		counter <= 1'b1;	
	end else 
		counter <= counter - 1;
end
endmodule

