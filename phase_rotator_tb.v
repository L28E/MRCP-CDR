`timescale 1ns/1ns
`include "phase_rotator.v"
`include "clock_divider4.v"
`include "phase_generator.v"

module phase_rotator_tb;

    // Declarations and instantiations
    wire [7:0] phase;
    wire clk_early, clk_edge, clk_late;  
    wire freq_div_out;   
    
    reg ref_clk;
    reg rst;
    reg inc, dec;
    reg reg_phase_rot_in;
    reg reg_freq_div_in;    

    phase_generator pgen(ref_clk,rst,phase);
    clock_divider4 freq_div(reg_freq_div_in,rst,freq_div_out);
    phase_rotator uut(reg_phase_rot_in, rst, inc, dec, phase, clk_early, clk_edge, clk_late);

    always@(posedge ref_clk) begin
        reg_freq_div_in <= clk_late;
        reg_phase_rot_in <= freq_div_out;
    end

    // Simulation
    always begin
	    #1 ref_clk = ~ref_clk;        
    end    

    task no_rotation; 
        begin
            ref_clk=0;
            inc=0;
            dec=0;

            #2 rst=0;
            #2 rst=1;
            #500;
        end
    endtask

    task increase_phase;
        // We should see that each time the phase rotator is clocked, the phase of the early, edge, and late signals is increased.
        begin
            ref_clk=0;
            inc=1;
            dec=0;

            #2 rst=0;
            #2 rst=1;
            #500;
        end
    endtask

    task decrease_phase;
        // We should see that each time the phase rotator is clocked, the phase of the early, edge, and late signals is decreased.
        begin
            ref_clk=0;
            inc=0;
            dec=1;

            #2 rst=0;
            #2 rst=1;
            #500;
        end
    endtask

    initial begin        
        $dumpfile("phase_rotator_tb.vcd");
        $dumpvars(0,phase_rotator_tb);

        ref_clk=0;
        no_rotation();
        increase_phase();
        decrease_phase();

        $finish;
    end   

endmodule