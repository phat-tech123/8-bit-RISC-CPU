`timescale 1ns / 1ps

module CPU_tb;

reg clk;
reg rst;

CPU CPU_u (
.clk(clk),
.rst(rst)
);

initial begin 
	$dumpfile("CPU.vcd");
	$dumpvars(0, CPU_tb);
end

initial 
begin
clk =0;
rst =0;
end

always 
begin
#25 clk = ~clk;
end

endmodule

