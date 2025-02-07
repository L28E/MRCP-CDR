cdr: cdr.v cdr_tb.v phase_generator.v mux8.v phase_rotator.v clock_divider4.v phase_detector.v filter.v prbs.v
	iverilog -o cdr_tb.vvp cdr_tb.v
	vvp cdr_tb.vvp
	gtkwave cdr_tb.vcd

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

clock_divider: clock_divider4.v clock_divider4_tb.v
	iverilog -o clock_divider4_tb.vvp clock_divider4_tb.v
	vvp clock_divider4_tb.vvp
	gtkwave clock_divider4_tb.vcd

phase_detector: phase_detector.v phase_detector_tb.v
	iverilog -o phase_detector_tb.vvp phase_detector_tb.v
	vvp phase_detector_tb.vvp
	gtkwave phase_detector_tb.vcd

filter: filter.v filter_tb.v
	iverilog -o filter_tb.vvp filter_tb.v
	vvp filter_tb.vvp
	gtkwave filter_tb.vcd

prbs: prbs.v prbs_tb.v
	iverilog -o prbs_tb.vvp prbs_tb.v
	vvp prbs_tb.vvp
	gtkwave prbs_tb.vcd

clean:
	rm -f *.vvp *.vcd