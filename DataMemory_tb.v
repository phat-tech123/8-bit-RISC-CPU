
module DM_tb;

reg clk, memWrite, memRead;
reg [4:0] address;
reg [7:0] data_in;
wire [7:0] data_out;

DM u_DM(
	.clk(clk),
	.memWrite(memWrite),
	.memRead(memRead),
	.address(address),
	.data_in(data_in),
	.data_out(data_out)
);

initial begin
	$dumpfile("DM.vcd");
	$dumpvars(0, DM_tb);
end

// Clock generation
initial begin
	clk = 0;
	forever #25 clk = ~clk;
end

initial begin
        // Initialize signals
        address = 5'b00000;
	memRead = 1'b0;
	memWrite = 1'b0;
	data_in = 8'b11111111;

        // Write operation
        #50;
	memWrite = 1'b1;

        // Read operation
        #100;
	memWrite = 1'b0;
	memRead = 1'b1;
        #50;

        // End simulation
        #2000;
        $finish;
end

endmodule
