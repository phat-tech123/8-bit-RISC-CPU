module PC(
    input wire clk, 
    input wire rst, 
    input wire stop,
    input wire [4:0] loaded_address, 
    output reg [4:0] address
);

reg [1:0] counter;

initial begin 
	address = 5'd0;
	counter = 2'd2;
end
always @(posedge clk or posedge rst) begin
	if (rst) begin
		address <= 5'd0; 
		counter <= 2'd2;
	end else if (stop) begin
		address <= 5'bz;
	end else if(counter == 2'd0) begin
		address <= loaded_address; 
		counter <= 2'd2;
	end else begin
		counter <= counter - 1;
	end
end
endmodule

module ADD_Mux(
   	input wire skip_signal, 
    	input wire [4:0] address, 
    	output reg [4:0] next_address // Use reg because it's assigned in always block
);
    // Compute the next address based on the skip signal
always @(*) begin
if (skip_signal)
    next_address = address + 5'd2; // skip by 2
else
    next_address = address + 5'd1; // increment by 1
end
endmodule

