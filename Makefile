all: phase_generator

phase_generator: phase_generator.v phase_generator_tb.v
	iverilog -o phase_generator_tb.vvp phase_generator_tb.v
	vvp phase_generator_tb.vvp
#	gtkwave phase_generator_tb.vcd

clean:
	rm -f *.vvp *.vcd