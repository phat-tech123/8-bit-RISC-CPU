# Simple RISC CPU Design

## Introduction
RISC (Reduced Instruction Set Computer) is a modern processor design approach. In this project, we design a simple RISC CPU with a **3-bit opcode** and **5-bit operand**, allowing for **8 instruction types** and **32 address spaces**. The processor operates based on clock and reset signals and halts execution upon receiving the HALT signal.

## Requirements
Utilize knowledge from **HDL logic design** and related subjects to design a simple RISC CPU on an **FPGA development kit** such as the **Arty-Z7** or an equivalent board.

### **System Components**
- **Program Counter**: Stores the program address register.
- **Address Mux**: Selects between program and instruction addresses.
- **Memory**: Stores and provides program data.
- **Accumulator Register**: Handles data from the ALU.
- **ALU (Arithmetic Logic Unit)**: Processes data from Memory, Accumulator, and Instruction opcode.

### **System Functionality**
1. Fetch instructions from Memory.
2. Decode instructions.
3. Retrieve operands from Memory (if required).
4. Execute the instruction and perform necessary operations.
5. Store results back into Memory or Accumulator.
6. Repeat until a termination instruction is encountered.

## Detailed Design
### **Program Counter**
- Essential for counting program instructions and states.
- Operates on the rising edge of the clock.
- Reset signal is active-high and resets the counter to `0`.
- Counter width: **5 bits**.
- Supports loading a specific value; otherwise, increments normally.

### **Address Mux**
- Selects between the instruction fetch address and operand address.
- Default width: **5 bits**.
- Width should be parameterized for flexibility.

### **ALU (Arithmetic Logic Unit)**
- Executes arithmetic and logical operations based on the **3-bit opcode**.
- Supports **8-bit operands** (`inA` and `inB`), producing an **8-bit output** and a **1-bit zero flag (`is_zero`)**.
- `is_zero` flag indicates whether `inA` is zero asynchronously.
- Operations based on opcode:

| Opcode | Code | Operation |
|--------|------|------------|
| HLT | 000 | Halt program execution |
| SKZ | 001 | Skip next instruction if ALU result is 0 |
| ADD | 010 | Add Accumulator value and Memory operand, store in Accumulator |
| AND | 011 | Bitwise AND between Accumulator and Memory operand, store in Accumulator |
| XOR | 100 | Bitwise XOR between Accumulator and Memory operand, store in Accumulator |
| LDA | 101 | Load value from Memory into Accumulator |
| STO | 110 | Store Accumulator value into Memory |
| JMP | 111 | Unconditional jump to target address |

### **Controller**
- Manages CPU control signals, including instruction fetch and execution.
- Operates on the rising edge of the clock.
- Reset signal is **synchronous and active-high**.
- 3-bit opcode directly corresponds to ALU operations.
- Must support at least **8 operational states**.

### **Registers**
- **8-bit input signal**.
- **Synchronous active-high reset**.
- Operates on the rising edge of the clock.
- When load signal is active, the input value is transferred to the output.
- Otherwise, the output value remains unchanged.

### **Memory**
- Stores **both instructions and data**.
- Implements **separate read/write functionality** using a **single bidirectional data port** (no simultaneous read/write).
- **5-bit address and 8-bit data width**.
- **1-bit read/write enable signal**.
- Operates on the rising edge of the clock.

## Getting Started

### Build & Run using iverilog 
1. Preparation:
   ```sh
   sudo apt install iverilog gtkwave
   git clone https://github.com/phat-tech123/RISC-CPU.git
   ```
2. Compile the design:
   ```sh
   make compile 
   make run
   ```
3. Waveform simulations:
   ```sh
   make wave 
   ```
