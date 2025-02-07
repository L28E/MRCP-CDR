`include "phase_rotator.v"
`include "clock_divider4.v"
`include "phase_generator.v"
`include "phase_detector.v"
`include "filter.v"

module cdr(input data_in,
           input ref_clk,
           input rst,
           output reg data_out,
           output reg clk_out);

    wire [7:0] phase;
    wire clk_early, clk_edge, clk_late;  
    wire freq_div_out;  
    wire inc, dec;  
    wire up, down;
        
    reg reg_phase_rot_in;
    reg reg_freq_div_in;    

    phase_generator phase_gen(ref_clk,rst,phase);
    clock_divider4 freq_div(reg_freq_div_in,rst,freq_div_out);
    phase_rotator phase_rot(reg_phase_rot_in, rst, inc, dec, phase, clk_early, clk_edge, clk_late);
    phase_detector phase_det(data_in,clk_early, clk_edge, clk_late,rst,up,down);
    filter filt(up,down,reg_freq_div_in,rst,dec,inc);

    always@(posedge ref_clk) begin
        reg_freq_div_in <= clk_late;
        reg_phase_rot_in <= freq_div_out;
        clk_out <= reg_freq_div_in;
    end

    always@(posedge clk_out) begin
        data_out <= data_in;
    end    

endmodule