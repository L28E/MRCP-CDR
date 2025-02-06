`timescale 1ns/1ns
`include "phase_detector.v"

module phase_detector_tb;

reg rst, Din, clk_early, clk_edge, clk_late;
wire up, down;

phasedetector uut(Din, clk_early, clk_edge, clk_late, rst, up, down);

task init;
    begin
        rst=0;
        Din=0;
        clk_early=0;
        clk_edge=0;
        clk_late=0;        
    end
endtask

task reset;
    begin
        rst=1;
        #5;
        rst=0;
    end
endtask

task no_transition;
    // No transition, output should be up=0, down=0
    begin
        clk_early = 1;
        #5 clk_early = 0;
        #5 clk_edge = 1;
        #5 clk_edge = 0;
        #5 clk_late = 1;
        #5 clk_late = 0;
        #5;
    end
endtask

task late_transition;
// Transition between edge and late, output should be up=0, down=1
    begin
        clk_early = 1;
        #5 clk_early = 0;
        #5 clk_edge = 1;
        #5 clk_edge = 0;
        #2 Din = 1;
        #3 clk_late = 1;        
        #5 clk_late = 0;
        Din = 0;
        #5;
    end
endtask

task early_transition;
// Transition between early and edge, output should be up=1, down=0
    begin
        clk_early = 1;
        #5 clk_early = 0;
        #2 Din = 1;
        #3 clk_edge = 1;
        #5 clk_edge = 0;
        #5 clk_late = 1;
        #5 clk_late = 0;
        Din = 0;
        #5;
    end
endtask

initial begin
    $dumpfile("phase_detector_tb.vcd");
    $dumpvars(0,phase_detector_tb);

    init();
    reset();
    no_transition();
    reset();
    late_transition();
    reset();
    early_transition();

    $finish;
end 

endmodule