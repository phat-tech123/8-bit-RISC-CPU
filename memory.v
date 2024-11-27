module memory(clk, instruction_data_in ,data_in, data_out, opcode, address_out, address_in, read, write);
input clk, read, write;
input[7:0] instruction_data_in;
input[7:0] data_in;
input[4:0] address_in;
output reg[7:0] data_out;
output reg[2:0] opcode;
output reg[4:0] address_out;


reg[7:0] mem [31:0];
initial begin
    	$readmemb("memory_data.mem", mem); // Load binary file
end


always@(posedge clk) begin
	if(mem[address_in][7:5] == 3'b110) 
		mem[mem[address_in][4:0]] <= data_in;		
	else begin
		opcode <= mem[address_in][7:5];
		address_out <= mem[address_in][4:0];
		case(mem[address_in][7:5])
			3'b110: out <= out;
			3'b111: out <= out;
		endcase
	end	
end

always@(posedge clk) begin
	s
end

endmodule
