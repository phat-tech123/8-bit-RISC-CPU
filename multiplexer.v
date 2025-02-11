module addressADD(
	input wire skipSignal,
    	input wire [4:0] address_in,
    	output wire [4:0] address_out
);
  	assign address_out = skipSignal ? (address_in + 2) : (address_in + 1);
endmodule

module addressMUX(
    	input wire jump,
    	input wire [4:0] nextAddress,
    	input wire [4:0] jumpAddress,
    	output wire [4:0] address_out
);
    	assign address_out = jump ? jumpAddress : nextAddress;
endmodule

module ALUmux(
    	input wire ALUtoACC,
    	input wire [7:0] ALUdata,
	input wire [7:0] MemoryData,
 	output wire [7:0] data_out
);
    	assign data_out = ALUtoACC ? ALUdata : MemoryData;
endmodule

