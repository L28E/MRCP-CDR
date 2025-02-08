`timescale 1ns/1ps
`include "cdr.v"
`include "prbs.v"

/*  
    We specify the parameters FREQ_COEFF, and REF_CLK_PERIOD where;
    
    f_s = FREQ_COEFF * (f_ref/8) 
    f_ref = 1/REF_CLK_PERIOD
    tx_clk_period = 1/f_s = 1/(FREQ_COEFF * (f_ref/8)) = REF_CLK_PERIOD * 8 / FREQ_COEFF

    We'll observe if data_out tracks data_in, and the frequency range over which the CDR can track.
    Note that the delays will get floored to the nearest integer.         
*/

module cdr_tb #(parameter FREQ_COEFF = 1.05,
                parameter REF_CLK_PERIOD = 20);

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
        #(REF_CLK_PERIOD * 8.0 / FREQ_COEFF / 2.0) tx_clk = ~tx_clk;        
    end

    always begin
        #(REF_CLK_PERIOD / 2.0) ref_clk = ~ref_clk;
    end
    
    initial begin
        $dumpfile("cdr_tb.vcd");
        $dumpvars(0,cdr_tb);
        $display ("ref_clk half period = %d",REF_CLK_PERIOD/2.0);
        $display ("tx_clk half period = %d",REF_CLK_PERIOD * 8 / FREQ_COEFF/2.0);

        tx_clk = 0;
        ref_clk = 0;
        rst = 0;
        prbs_rst = 0;

        #10 prbs_rst = 1;
        #20 rst = 1;
        #(REF_CLK_PERIOD*1000);
        rst = 0;
        #5;

        $finish;
    end
endmodule