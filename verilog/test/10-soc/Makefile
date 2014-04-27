OBJ := soc_tb

.PHONY: $(OBJ)

all: $(OBJ) test

$(OBJ): $(OBJ).v
	iverilog -gsystem-verilog $< -o $@ -I.. -I../..

test: $(OBJ)
	./$(OBJ)