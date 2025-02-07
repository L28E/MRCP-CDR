`include "mux8.v"

module phase_rotator (input clk,
                      input rst,
                      input inc,
                      input dec,
                      input [7:0] phase,
                      output CLK_early,
                      output CLK_edge,
                      output CLK_late);

reg [2:0] count; 
mux8 early_mux(phase[0],phase[1],phase[2],phase[3],phase[4],phase[5],phase[6],phase[7],count,CLK_early);
mux8 edge_mux(phase[2],phase[3],phase[4],phase[5],phase[6],phase[7],phase[1],phase[0],count,CLK_edge);
mux8 late_mux(phase[4],phase[5],phase[6],phase[7],phase[0],phase[1],phase[2],phase[3],count,CLK_late);

always @(posedge clk or negedge rst)
    if (~rst)
        count <= 0;  
    else begin
        // inc and dec should never be asserted simoultaneously if the digital filter is working correctly
        if (inc)   
            count <= count + 1; // Rolls over to 0 if count is at 7
        else if (dec)
            count <= count - 1; // Rolls over to 7 if count is at 0 
    end
endmodule


