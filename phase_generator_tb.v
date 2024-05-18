`timescale 1ns/1ns
`include "phase_generator.v"

module phase_generator_tb;

    reg clk;
    reg rst;
    wire [7:0] phase;

    phase_generator uut(clk,rst,phase);

    always begin
	    #5 clk = ~clk;
    end

    initial begin        
        $dumpfile("phase_generator_tb.vcd");
        $dumpvars(0,phase_generator_tb);

        clk = 0;
        rst = 1;
        #20;
        rst = 0;
        #100;
        rst = 1;
        #5;

        $finish;
    end   

endmodule