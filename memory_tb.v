`timescale 1ns/1ps
module memory_tb;
    reg clk;
    reg [4:0] address;       // Match the `address` width in the DUT
    reg [7:0] data_in;       // Separate signal for driving data
    wire [7:0] data;         // Connect as inout to DUT
    reg write_en;
    reg data_dir;            // Signal to control data direction for testbench

    // Instantiate the memory module
    memory u_memory (
        .clk(clk),
        .address(address),
        .data(data),
        .write_en(write_en)
    );

    // Tri-state buffer for simulating bidirectional data
    assign data = (data_dir) ? data_in : 8'bz;

    // Generate VCD file for waveform analysis
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
        data_dir = 0;

        // Write operation
        #50;
        address = 5'b10001;   // Write to address 17
        data_in = 8'b11111111;
        data_dir = 1;         // Drive data
        write_en = 1;         // Enable write
        #50;
        //write_en = 0;         // Disable write
        //data_dir = 0;         // Release data line

        // Read operation
        #100;
        //address = 5'b10001;   // Read from address 17
        //write_en = 0;         // Ensure write is disabled
        #50;

        // End simulation
        #200;
        $finish;
    end
endmodule

