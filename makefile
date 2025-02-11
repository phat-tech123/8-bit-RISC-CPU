# Makefile for RISC CPU Simulation

IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
OUTPUT = datapath_wav
SRC = datapath.v datapath_tb.v
VCD_FILE = CPU.vcd

all: compile run wave

compile:
	$(IVERILOG) -o $(OUTPUT) $(SRC)

run:
	$(VVP) $(OUTPUT)

wave:
	$(GTKWAVE) $(VCD_FILE)

clean:
	rm -f $(OUTPUT) $(VCD_FILE)

