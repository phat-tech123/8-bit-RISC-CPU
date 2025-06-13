module Memory #( 
    parameter WIDTH_ADDRESS_BIT = 5,
    parameter WIDTH_REG = 8
)(
    input clk,
    input rd,
    input wr,
    input [WIDTH_ADDRESS_BIT - 1:0] addr,
    inout [WIDTH_REG-1:0] data);
    
    reg [WIDTH_REG-1:0] mem [0:2**WIDTH_ADDRESS_BIT-1];
    reg [WIDTH_REG-1:0] data_out;
    
    assign data = (rd && !wr) ? data_out : 8'bz;
    
    // Initialize memory with the assembly program
    initial begin
	    $readmemb("RTL/../Program/PROG1.bin",mem);
    end

    always @(posedge clk) begin
        if (wr)
            mem[addr] <= data;
        else if (rd && !wr)
            data_out <= mem[addr];
        else
            data_out <= data_out;
    end
endmodule
