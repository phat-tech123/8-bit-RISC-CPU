`timescale 1ns / 1ps

module DatapthUnit_tb;

reg clk;
reg rst;

Datapath_Unit Datapath_Unit_u (
.clk(clk),
.rst(rst)
);

initial begin 
	$dumpfile("Datapath_Unit.vcd");
	$dumpvars(0, DatapthUnit_tb);
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
