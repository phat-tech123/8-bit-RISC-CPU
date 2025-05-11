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

## Simple Run on Termial

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
## Cadence tool
### Simulation using Cadence Xcelium
#### PROGRAM 1
```sh
//opcode_operand  // addr                   assembly code
//--------------  // ----  -----------------------------------------------
    111_11110     //  00   BEGIN:   JMP TST_JMP
    000_00000     //  01            HLT        //JMP did not work at all
    000_00000     //  02            HLT        //JMP did not load PC, it skipped
    101_11010     //  03   JMP_OK:  LDA DATA_1
    001_00000     //  04            SKZ
    000_00000     //  05            HLT        //SKZ or LDA did not work
    101_11011     //  06            LDA DATA_2
    001_00000     //  07            SKZ
    111_01010     //  08            JMP SKZ_OK
    000_00000     //  09            HLT        //SKZ or LDA did not work
    110_11100     //  0A   SKZ_OK:  STO TEMP   //store non-zero value in TEMP
    101_11010     //  0B            LDA DATA_1
    110_11100     //  0C            STO TEMP   //store zero value in TEMP
    101_11100     //  0D            LDA TEMP
    001_00000     //  0E            SKZ        //check to see if STO worked
    000_00000     //  0F            HLT        //STO did not work
    100_11011     //  10            XOR DATA_2
    001_00000     //  11            SKZ        //check to see if XOR worked
    111_10100     //  12            JMP XOR_OK
    000_00000     //  13            HLT        //XOR did not work at all
    100_11011     //  14   XOR_OK:  XOR DATA_2
    001_00000     //  15            SKZ
    000_00000     //  16            HLT        //XOR did not switch all bits
    000_00000     //  17   END:     HLT        //CONGRATULATIONS - TEST1 PASSED!
    111_00000     //  18            JMP BEGIN  //run test again

    00000000      //  1A   DATA_1:             //constant 00(hex)
    11111111      //  1B   DATA_2:             //constant FF(hex)
    10101010      //  1C   TEMP:               //variable - starts with AA(hex)

    111_00011     //  1E   TST_JMP: JMP JMP_OK
    000_00000     //  1F            HLT        //JMP is broken
```
![Program 1 Simulation Result](prog1.png)

