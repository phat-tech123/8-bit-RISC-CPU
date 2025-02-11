module DM(
	clk,
	memWrite,
	memRead,
	address,
	data_in,
	data_out
);

parameter DATA_WIDTH = 8;
parameter ADDRESS_WIDTH = 5;
parameter MEMORY_DEPTH = 32;

input wire clk, memWrite, memRead;
input wire [ADDRESS_WIDTH-1:0] address;
input wire [DATA_WIDTH-1:0] data_in;
output reg [DATA_WIDTH-1:0] data_out;

reg [DATA_WIDTH-1:0] data [MEMORY_DEPTH-1:0];

initial begin
        $readmemb("./data.mem", data, 0, MEMORY_DEPTH-1);
end

always@(posedge clk) begin
	if(memWrite) 
		data[address] <= data_in;
	else if(memRead)
		data_out <= data[address];
end

endmodule

