`timescale 1ns/1ns
`include "phase_rotator.v"

module phase_rotator_tb;

    reg clk;
    reg rst;
    reg inc;
    reg dec;
    reg [7:0] phase;
    wire clk_early, clk_edge, clk_late;

    phase_rotator uut(clk,rst,inc,dec,phase,clk_early,clk_edge,clk_late);

    always begin
	    #35 clk = ~clk;        
    end

    always begin
        #10 phase = (phase << 1) | (phase >> 7); // Circular shift
    end

    initial begin        
        $dumpfile("phase_rotator_tb.vcd");
        $dumpvars(0,phase_rotator_tb);

        clk = 0;
        rst = 1;
        phase = 1;
        inc=0;
        dec=0;
        #10;
        rst = 0;
        #100;
        inc = 1;
        #100;
        inc = 0;
        dec = 1;
        #100;
        $finish;
    end   

endmodule