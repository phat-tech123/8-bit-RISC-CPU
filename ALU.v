module ALU(
	input wire [1:0] ALU_Op,
	input wire [7:0] inA,
	input wire [7:0] inB,
	output reg isZero,
	output reg [7:0] out
);

always@(*) begin
	case(ALU_Op)
		2'b00: out = out;
		2'b01: out = inA + inB;
		2'b10: out = inA & inB;
		2'b11: out = inA ^ inB;
	endcase
	isZero = (out == 0) ? 1 : 0;
end


endmodule;
