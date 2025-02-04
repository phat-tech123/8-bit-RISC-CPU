module ACC_tb;

reg clk;
reg ACCwrite;
reg [7:0] in;
wire [7:0] out;

ACC u_ACC(
	.clk(clk),
	.ACCwrite(ACCwrite),
	.in(in),
	.out(out)
);

initial begin
	$dumpfile("ACC.vcd");
	$dumpvars(0, ACC_tb);
end

initial begin 
	clk = 0;
	ACCwrite = 0;
	in = 8'b00000000;
	ACCwrite = 1;
	#45;
	in = 8'b10101010;
	#40;
	ACCwrite = 0;
	in = 8'b10000001;
	#200;
end
initial begin
	forever begin 
		clk = #25 ~clk;
	end
end


endmodule
