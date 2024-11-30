module memory(
    input wire clk,
    input wire write_en,
    input wire [4:0] address, 
    inout wire [7:0] data
);
    reg [7:0] mem [31:0]; 
    reg [7:0] data_out;
   // reg data_enable;  

    initial begin
        $readmemb("./instruction.mem", mem, 0, 15);
        $readmemb("./data.mem", mem, 16, 31);
    end

    // Tri-state buffer for inout port
    assign data = (!write_en) ? data_out : 8'bz;

    always @(posedge clk) begin
        if (write_en) begin
            //write 
            mem[address] <= data;
        end else begin
	    //read
            data_out = mem[address];
        end
    end

    // Save data memory to file for simulation purposes
    always @(posedge clk) begin
        $writememb("./data.mem", mem, 16, 31);
    end

endmodule

