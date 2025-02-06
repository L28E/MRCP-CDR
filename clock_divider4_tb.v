`timescale 1ns/1ns
`include "clock_divider4.v"

module clock_divider4_tb;

    reg clk_in;
    reg rst;
    wire clk_out;

    clock_divider4 uut(clk_in,rst,clk_out);

    always begin
	    #5 clk_in = ~clk_in;
    end

    initial begin
        $dumpfile("clock_divider4_tb.vcd");
        $dumpvars(0,clock_divider4_tb);

        clk_in = 0;
        rst = 1;
        #20;
        rst = 0;
        #200;
        rst = 1;
        #5;

        $finish;    
    end



endmodule