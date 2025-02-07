`timescale 1ns/1ns
`include "prbs.v"

module prbs_tb;

    reg clk;
    reg rst;
    wire data;

    prbs uut(clk,rst,data);

    always  
        #5 clk = ~clk;

    initial begin
        $dumpfile("prbs_tb.vcd");
        $dumpvars(0,prbs_tb);

        clk=0;
        rst=1;
        #2 rst=0; 
        #2 rst=1;        
        #1000;

        $finish;
    end
endmodule