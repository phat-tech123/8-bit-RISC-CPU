module AddressMux(
	input wire PC_addr,
	input wire PC_actve,
	input wire [4:0] instruction_address,
	input wire [4:0] data_address,
	output reg [4:0] address
);

initial begin 
	address <= 5'b00000;
end

always@(*) begin
	if(PC_actve == 1'b0) begin
		address = address;
	end else if (PC_addr == 1'b1) begin
		address = data_address;
	end else begin 
		address = instruction_address;
	end

//	if(PC_addr == 1'b0 && PC_actve == 1'b0) begin
//		address = stayed_address;
//	end else if (PC_addr == 1'b1 && PC_actve == 1'b1) begin
//		address <= data_address;
//	end else if (PC_addr == 1'b0 && PC_actve == 1'b1) begin
//		address <= instruction_address;
//	end else begin
//		address <= address;
	//end
end


endmodule
