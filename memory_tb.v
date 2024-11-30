`timescale 1ns/1ps
module memory_tb;
    reg clk;
    reg [4:0] address;      
    reg [7:0] data_in;     
    wire [7:0] data;      
    reg write_en;

    // Instantiate the memory module
    memory u_memory (
        .clk(clk),
        .address(address),
        .data(data),
        .write_en(write_en)
    );

    assign data = data_in;

    initial begin
        $dumpfile("memory.vcd");
        $dumpvars(0, memory_tb);
    end

    // Clock generation
    initial begin
        clk = 0;
        forever #25 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize signals
        address = 5'b00000;
        data_in = 8'b00000000;
        write_en = 0;

        // Write operation
        #50;
        address = 5'b10001;   // Write to address 17
        data_in = 8'b11111111;
        write_en = 1;         // Enable write
        #50;
        write_en = 0;         // Disable write

        // Read operation
        #100;
        address = 5'b10001;   // Read from address 17
        write_en = 0;         // Ensure write is disabled
        #50;

        // End simulation
        #2000;
        $finish;
    end
endmodule

