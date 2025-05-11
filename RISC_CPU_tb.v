module RICS_CPU_tb;
    reg clk;
    reg reset;
    wire HALT;
    wire [4:0] pcc;
    wire [7:0] result;
    // Kh?i t?o CPU
    RICS_CPU #(.WIDTH_REG(8), .OPCODE(3)) cpu(.clk(clk), .reset(reset),.result(result),.pcc(pcc),.HALT(HALT));
    
    // T?o xung clock
    always #5 clk = ~clk;
    
    initial begin
        // Kh?i t?o
        clk = 0;
        reset = 1;
        
        // Reset h? th?ng
        #10 reset = 0;
        
        // Ch?y ?? th?i gian ?? th?c thi m?t s? l?nh
        #10000 $finish;
    end
	    
    // Theo dõi các tín hi?u quan tr?ng
    initial begin
	$dumpfile("RICS_CPU.vcd");
	$dumpvars(0, RICS_CPU_tb);
    end
    initial begin
        $monitor("Time=%0t PC=%h Opcode=%b Operand=%d Acc=%d", 
                 $time, cpu.pc_out, cpu.opcode, cpu.operand, cpu.acc_out);
    end

endmodule
