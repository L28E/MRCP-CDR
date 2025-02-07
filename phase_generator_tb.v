`timescale 1ns/1ns
`include "phase_generator.v"

module phase_generator_tb;

    reg clk;
    reg rst;
    wire [7:0] phase;

    phase_generator uut(clk,rst,phase);

    always begin
	    #1 clk = ~clk;
    end

    initial begin        
        $dumpfile("phase_generator_tb.vcd");
        $dumpvars(0,phase_generator_tb);

        clk = 0;
        rst = 0;
        #20;
        rst = 1;
        #100;
        rst = 0;
        #5;

        $finish;
    end   

endmodule