module ALU #( 
    parameter WIDTH_REG = 8,
    parameter OPCODE = 3
)(
    input [OPCODE-1:0] opcode,
    input [WIDTH_REG-1:0] inA,
    input [WIDTH_REG-1:0] inB,
    output[WIDTH_REG-1:0] out,
    output is_zero
);
    reg [WIDTH_REG-1 : 0] result;
  
  always @ (*)
    begin
      case(opcode)
        3'b000 : result = inA;
        3'b001 : result = inA;
        3'b010 : result = inA + inB;
        3'b011 : result = inA & inB;
        3'b100 : result = inA ^ inB;
        3'b101 : result = inB;
        3'b110 : result = inA;
        3'b111 : result = inA;
        default : result = {WIDTH_REG{1'b0}};
      endcase
    end
  
  assign is_zero = (result) ? 1'b0 : 1'b1;
  assign out = result;
endmodule
