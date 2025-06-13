module Controller(
    input clk,
    input reset,
    input [2:0] opcode,
    input is_zero,
    output reg sel,
    output reg rd,
    output reg ld_ir,
    output reg halt,
    output reg inc_pc,
    output reg ld_ac,
    output reg ld_pc,
    output reg wr,
    output reg data_e
);
    // Các tr?ng thái
    parameter INST_ADDR = 0;
    parameter INST_FETCH = 1;
    parameter INST_LOAD = 2;
    parameter IDLE = 3;
    parameter OP_ADDR = 4;
    parameter OP_FETCH = 5;
    parameter ALU_OP = 6;
    parameter STORE = 7;
    
    reg [2:0] state;
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= INST_ADDR;
            sel <= 0;
            rd <= 0;
            ld_ir <= 0;
            halt <= 0;
            inc_pc <= 0;
            ld_ac <= 0;
            ld_pc <= 0;
            wr <= 0;
            data_e <= 0;
        end
        else begin
            case(state)
                INST_ADDR: begin
                    sel <= 1;
                    rd <= 0;
                    ld_ir <= 0;
                    halt <= 0;
                    inc_pc <= 0;
                    ld_ac <= 0;
                    ld_pc <= 0;
                    wr <= 0;
                    data_e <= 0;
                    state <= INST_FETCH;
                end
                
                INST_FETCH: begin
                    sel<=1;
                    rd <= 1;
                    ld_ir <= 0;
                    halt <= 0;
                    inc_pc <= 0;
                    ld_ac <= 0;
                    ld_pc <= 0;
                    wr <= 0;
                    data_e <= 0;
                    state <= INST_LOAD;
                end
                
                INST_LOAD: begin
                    sel<=1;
                    rd <= 1;
                    ld_ir <= 1;
                    halt <= 0;
                    inc_pc <= 0;
                    ld_ac <= 0;
                    ld_pc <= 0;
                    wr <= 0;
                    data_e <= 0;
                    state <= IDLE;
                end
                
                IDLE: begin
                    sel<=1;
                    rd <= 1;
                    ld_ir <= 1;
                    halt <= 0;
                    inc_pc <= 0;
                    ld_ac <= 0;
                    ld_pc <= 0;
                    wr <= 0;
                    data_e <= 0;
                    state <= OP_ADDR;
                end
                
                OP_ADDR: begin
                    sel<=0;
                    rd <= 0;
                    ld_ir <= 0;
                    if(opcode==3'b000)begin
                        halt<=1;
                        state <= OP_ADDR;
                    end
                    else begin 
                        inc_pc<=1;
                        state <= OP_FETCH;
                    end
                    wr <= 0;
                    data_e <= 0;
                end
                
                OP_FETCH: begin
                    sel<=0;
                    ld_ir <= 0;
                    inc_pc <= 0;
                    wr <= 0;
                    data_e <= 0;
                    rd <= (opcode == 3'b010 || opcode == 3'b011 || 
                          opcode == 3'b100 || opcode == 3'b101);
                    state <= ALU_OP;
                end
                
                ALU_OP: begin
                    sel<=0;
                    ld_ir <= 0;
                    ld_pc <= (opcode == 3'b111);
                    wr <= 0; 
                    data_e <= (opcode == 3'b110);
                    rd <= (opcode == 3'b010 || opcode == 3'b011 || 
                          opcode == 3'b100 || opcode == 3'b101);
                    inc_pc <= (opcode == 3'b001 && is_zero); // SKZ if zero
                    
                    state <= STORE;
                end
                
                STORE: begin
                    sel<=0;
                    ld_ir <= 0;
                    inc_pc <= 0;
                    ld_ac <= (opcode == 3'b010 || opcode == 3'b011 || 
                          opcode == 3'b100 || opcode == 3'b101);
                    rd <= (opcode == 3'b010 || opcode == 3'b011 || 
                          opcode == 3'b100 || opcode == 3'b101);
                    ld_pc <= (opcode == 3'b111);
                    wr <= (opcode == 3'b110); // STO
                    data_e <= (opcode == 3'b110); // STO
                    state <= INST_ADDR;
                end
		
		default: begin
                    sel<=sel;
                    ld_ir <= ld_ir;
                    inc_pc <= inc_pc;
                    ld_ac <=  ld_ac; 
                    rd <= rd; 
                    ld_pc <= ld_pc;
                    wr <= wr; // STO
                    data_e <= data_e; // STO
                    state <= state;
		end
            endcase
            
        end
    end
endmodule
