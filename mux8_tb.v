`timescale 1ns/1ns
`include "mux8.v"

module mux8_tb;

    reg [7:0] in;
    reg [2:0] select;
    wire out;

    mux8 uut(in[0],in[1],in[2],in[3],in[4],in[5],in[6],in[7],select,out);

    initial begin        
        $dumpfile("mux8_tb.vcd");
        $dumpvars(0,mux8_tb);

        in = 8'b10101010;
        select = 0;
        #5;
        select = select + 1;
        #5;
        select = select + 1;
        #5;
        select = select + 1;
        #5;
        select = select + 1;
        #5;
        select = select + 1;
        #5;
        select = select + 1;
        #5;
        select = select + 1;
        $finish;
    end   

endmodule