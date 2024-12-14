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

module ADD_Mux(
   	input wire skip_signal, 
	input wire nonAdd,
    	input wire [4:0] address, 
    	output reg [4:0] next_address 
);
always @(*) begin
	if(nonAdd) 
		next_address = address;    	//Load data
	else if (skip_signal)
	    next_address = address + 5'd2; 	// skip by 2
	else
	    next_address = address + 5'd1; 	// increment by 1
end
endmodule

