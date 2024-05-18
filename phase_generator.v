// Generates 8 phases 
module phase_generator (input clk,
                        input rst,
                        output reg [7:0] phase);

always @(posedge clk or posedge rst)
    	if (rst) 
		    phase <= 8'b00000001;            
        else
            phase <= (phase << 1) | (phase >> 7); // Circular shift
endmodule