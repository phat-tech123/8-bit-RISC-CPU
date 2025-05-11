module InstructionRegister#( 
    parameter WIDTH_ADDRESS_BIT = 5,
    parameter WIDTH_REG = 8,
    parameter OPCODE = 3
)(
    input clk,
    input reset,
    input load,
    input [WIDTH_REG-1:0] data_in,
    output reg [OPCODE-1:0] opcode,
    output reg [WIDTH_ADDRESS_BIT - 1:0] operand
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            opcode <= 3'b0;
            operand <= 5'b0;
        end
        else if (load) begin
            opcode <= data_in[WIDTH_REG-1:WIDTH_ADDRESS_BIT];
            operand <= data_in[WIDTH_ADDRESS_BIT:0];
        end
	else begin
	    opcode <= opcode;
	    operand <= operand;
	end
    end
endmodule
