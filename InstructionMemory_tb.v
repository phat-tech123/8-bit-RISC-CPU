module IM_tb;

reg clk, Halt;
reg [4:0] address;
wire [7:0] instruction_out;

IM u_IM(
	.clk(clk),
	.Halt(Halt),
	.address(address),
	.instruction_out(instruction_out)
);

initial begin
	$dumpfile("IM.vcd");
	$dumpvars(0, IM_tb);
end

// Clock generation
initial begin
	clk = 0;
	forever #25 clk = ~clk;
end

initial begin
        // Initialize signals
        address = 5'b00000;
	Halt = 1'b0;

        // Write operation
        #50;
        address = 5'b10001;   // Write to address 17
        // Read operation
        #100;
        address = 5'b10010;   // Read from address 17
        #50;
	Halt = 1'b1;
        // End simulation
	#70;
	address = 5'b10001;
        #2000;
        $finish;
end

endmodule
