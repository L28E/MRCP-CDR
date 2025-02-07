/* 
    Generates 8 discrete clock phases, with which we align the clock to the data edge 
    and becuase we are over sampling, the other clock edges sample the eye (ideally at the center).
*/
module phase_generator (input clk,
                        input rst,
                        output reg [7:0] phase);

always @(posedge clk or negedge rst)
    if (~rst)
        phase <= 8'b00000001;            
    else
        phase <= (phase << 1) | (phase >> 7); // Circular shift
endmodule