module controller_tb;

reg clk;
reg [2:0] opcode;
wire jump;
wire skip;
wire memWrite;
wire memRead;
wire ACCwrite;
wire ALUtoACC;
wire [1:0]ALU_OP; 
wire Halt;

controller u_controller(.*);

initial begin
	$dumpfile("controller.vcd");
	$dumpvars(0, controller_tb);
end

initial begin 
	clk = 0;
	forever #25 clk = ~clk;
end

initial begin
	opcode = 3'b001;
	#60;
	opcode = 3'b100;
	#20;
	opcode = 3'b000;
	#200;
	$finish;
end
endmodule
