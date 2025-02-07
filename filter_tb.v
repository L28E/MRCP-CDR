`timescale 1ns/1ns
`include "filter.v"

module filter_tb;

    wire out_p;
    wire out_n;

    reg in_p;
    reg in_n;
    reg clk;
    reg rst;

    filter uut(in_p,in_n,clk,rst,out_p,out_n);

    always begin
	    #5 clk = ~clk;
    end

    initial begin
        $dumpfile("filter_tb.vcd");
        $dumpvars(0,filter_tb);

        clk=0;
        in_n=0;
        in_p=0;
        rst=1;
        #2 rst=0;
        #2 rst=1;

        // in_p, no in_n. Should see out_p=1
        #20 in_p=1;
        #20;

        // introduce in_n, both outputs should be 0.
        in_n=1;
        #20;

        //remove in_p, should see out_n=1 after 4 clock periods
        in_p=0;
        #50;

        $finish;
    end


endmodule