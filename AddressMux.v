module AddressMux(
	input wire PC_addr,
	input wire PC_actve,
	input wire skip_signal,
	input wire skip,
	input wire [4:0] instruction_address,
	input wire [4:0] skip_address,
	input wire [4:0] data_address,
	output reg [4:0] address
);

initial begin 
	address <= 5'b00000;
end

always@(*) begin
	if(skip_signal == 1'b0) begin
		if(PC_actve == 1'b0) begin
			address = address;
		end else if(skip == 1'b1) begin 
			address = instruction_address;
		end else if (PC_addr == 1'b1) begin
			address = data_address;
		end else begin 
			address = instruction_address;
		end
	end else begin 
		if(PC_actve == 1'b0) begin
			address = address;
		//end else if (PC_addr == 1'b1) begin
		//	address = skip_address;
		end else begin 
			address = skip_address;
		end
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
