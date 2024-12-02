module ALU_tb;
reg [1:0] ALU_Op;
reg [7:0] inA;
reg [7:0] inB;
wire isZero;
wire [7:0] out;

        
ALU uut (
	.ALU_Op(ALU_Op),
	.inA(inA),
        .inB(inB),
        .isZero(isZero),
        .out(out)
);

initial begin 
	$dumpfile("ALU.vcd");
	$dumpvars(0,ALU_tb);
end

initial begin
        // Test ADD
        ALU_Op = 2'b00; inA = 8'd10; inB = 8'd20;
        #10;

        // Test SUB
        ALU_Op = 2'b01; inA = 8'd30; inB = 8'd30;
        #10;

        // Test AND
        ALU_Op = 2'b10; inA = 8'b11001100; inB = 8'b10101010;
        #10;

        // Test OR
        ALU_Op = 2'b11; inA = 8'b11001100; inB = 8'b10101010;
        #10;

        $stop;
end
endmodule

