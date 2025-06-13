# Makefile for RISC CPU Simulation

IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

OUTPUT_DIR = Output
OUTPUT = $(OUTPUT_DIR)/RISC_CPU
VCD_FILE = $(OUTPUT_DIR)/RISC_CPU.vcd

SRC = \
  RTL/multiplexer.v \
  RTL/PC.v \
  RTL/Memory.v \
  RTL/InstructionRegister.v \
  RTL/ALU.v \
  RTL/ACC.v \
  RTL/controller.v \
  RTL/RISC_CPU.v \
  Testbench/RISC_CPU_tb.v

all: compile run wave

compile: $(OUTPUT_DIR)
	$(IVERILOG) -o $(OUTPUT) $(SRC)

run:
	$(VVP) $(OUTPUT)

wave:
	$(GTKWAVE) $(VCD_FILE)

clean:
	rm -f $(OUTPUT) $(VCD_FILE)

$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

.PHONY: all compile run wave clean
