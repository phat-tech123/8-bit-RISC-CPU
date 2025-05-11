# Makefile for RISC CPU Simulation

IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
OUTPUT = RISC_CPU
SRC = RISC_CPU.v RISC_CPU_tb.v
VCD_FILE = RISC_CPU.vcd

all: compile run wave

compile:
	$(IVERILOG) -o $(OUTPUT) $(SRC)

run:
	$(VVP) $(OUTPUT)

wave:
	$(GTKWAVE) $(VCD_FILE)

clean:
	rm -f $(OUTPUT) $(VCD_FILE)

