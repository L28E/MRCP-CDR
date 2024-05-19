all: phase_generator mux8 phase_rotator

phase_generator: phase_generator.v phase_generator_tb.v
	iverilog -o phase_generator_tb.vvp phase_generator_tb.v
	vvp phase_generator_tb.vvp
	gtkwave phase_generator_tb.vcd

mux8: mux8.v mux8_tb.v
	iverilog -o mux8_tb.vvp mux8_tb.v
	vvp mux8_tb.vvp
	gtkwave mux8_tb.vcd

phase_rotator: phase_rotator.v phase_rotator_tb.v
	iverilog -o phase_rotator_tb.vvp phase_rotator_tb.v
	vvp phase_rotator_tb.vvp
	gtkwave phase_rotator_tb.vcd

clean:
	rm -f *.vvp *.vcd