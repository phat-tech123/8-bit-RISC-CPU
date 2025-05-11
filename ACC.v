module Accumulator#( 
    parameter WIDTH_REG = 8
)(
    input clk,
    input reset,
    input load,
    input [WIDTH_REG - 1:0] data_in,
    output reg [WIDTH_REG - 1:0] data_out
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            data_out <= 8'b0;
        else if (load)
            data_out <= data_in;
	else 
  	    data_out <= data_out;
    end
endmodule
