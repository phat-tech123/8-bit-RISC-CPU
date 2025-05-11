module ProgramCounter #(
    parameter WIDTH_ADDRESS_BIT = 5 
)(
    input clk,
    input reset,
    input load,
    input inc,
    input [WIDTH_ADDRESS_BIT - 1:0] data_in,
    output reg [WIDTH_ADDRESS_BIT - 1:0] data_out
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            data_out <= 5'b0;
        else if (load)
            data_out <= data_in;
        else if (inc)
            data_out <= data_out + 5'b00001;
	else
	    data_out <= data_out;
    end
endmodule
