module ACC_tb;

reg clk;
reg [7:0] in;
wire [7:0] out;

ACC u_ACC(
	.clk(clk),
	.in(in),
	.out(out)
);

initial begin
	$dumpfile("ACC.vcd");
	$dumpvars(0, ACC_tb);
end

initial begin
	forever begin 
		clk = #25 ~clk;
	end
end

initial begin 
	clk = 0;
	in = 8'b00000000;
	#45;
	in = 8'b10101010;
	#40;
	in = 8'b10000001;
	#200;
end

endmodule
