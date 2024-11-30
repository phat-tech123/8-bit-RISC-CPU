module memory(
    input wire clk,
    input wire write_en,
    input wire [4:0] address, // 5-bit address for 32 memory locations
    inout wire [7:0] data
);

    reg [7:0] mem [31:0]; // 32 bytes of memory (16 for instructions and 16 for data)
    reg [7:0] data_out;   // Register to hold output data
    reg data_enable;      // Signal to enable output data

    // Load initial values from files
    initial begin
        $readmemb("./instruction.mem", mem, 0, 15);
        $readmemb("./data.mem", mem, 16, 31);
    end

    // Tri-state buffer for inout port
    assign data = (data_enable) ? data_out : 8'bz;

    always @(posedge clk) begin
        if (write_en) begin
            // Write operation
            mem[address] <= data;
            data_enable <= 0; // Disable output during write
        end else begin
            // Read operation
            data_out <= mem[address];
            data_enable <= 1; // Enable output during read
        end
    end

    // Save data memory to file for simulation purposes
    always @(posedge clk) begin
        $writememb("./data.mem", mem, 16, 31);
    end

endmodule

