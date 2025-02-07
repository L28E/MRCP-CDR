`timescale 1ns/1ns
`include "cdr.v"
`include "prbs.v"

// TODO: Looks like it's working, but needs more thorough testing

module cdr_tb;

    reg tx_clk;
    reg prbs_rst;
    reg ref_clk;
    reg rst;

    wire data_in;
    wire data_out;
    wire clk_out;

    prbs data_gen(tx_clk,prbs_rst,data_in);
    cdr cdr_uut(data_in,ref_clk,rst,data_out,clk_out);

    always begin
        #8 tx_clk = ~tx_clk;
    end

    always begin
        #1 ref_clk = ~ref_clk;
    end
    
    initial begin
        $dumpfile("cdr_tb.vcd");
        $dumpvars(0,cdr_tb);

        tx_clk = 0;
        ref_clk = 0;
        rst = 0;
        prbs_rst = 0;

        #10 prbs_rst = 1;
        #20 rst = 1;
        #200;
        rst = 0;
        #5;

        $finish;
    end
endmodule