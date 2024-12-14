module PC(
    input wire clk, 
    input wire rst, 
    input wire stop,
    input wire [4:0] loaded_address, 
    output reg [4:0] address
);

initial begin 
	address = 5'd0;
end

always @(posedge clk or posedge rst) begin
	if (rst) begin
		address <= 5'd0; 
	end else if (stop) begin
		address <= 5'bz;
	end else begin
		address <= loaded_address;
	end
end
endmodule

module Adder_1(
    	input wire [4:0] address, 
    	output reg [4:0] next_address 
);
always @(*) begin
	    next_address = address + 5'd1; 	// increment by 1
end
endmodule

module Adder_2(
    	input wire [4:0] address, 
    	output reg [4:0] next_address 
);
always @(*) begin
	    next_address = address + 5'd2; 	// increment by 1
end
endmodule

module skip_data_mux(
	input wire [4:0] inA, 
	input wire [4:0] inB,
	input wire skip_signal,
	output reg [4:0] skip_data_address
);

always @(*) begin
	skip_data_address = (skip_signal) ? inA : inB;
end

endmodule
