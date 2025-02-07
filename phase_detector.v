/* 
    Bang Bang phase detector, used to determine if we are in phase with the incoming data.
*/
module phase_detector(input Din,
                     input clk_early,
                     input clk_edge,
                     input clk_late,
                     input rst,
                     output reg up,
                     output reg down);

reg reg_early;
reg reg_edge;
reg reg_late;

always @(posedge clk_early or posedge clk_edge or posedge clk_late or negedge rst)
    if (~rst)begin
        reg_early <= 0;
        reg_edge <= 0;
        reg_late <= 0;
        up <= 0;
        down <=0;
    end
    else if (clk_early)
        reg_early <= Din;            
    else if (clk_edge)
        reg_edge <= Din;
    else if (clk_late) begin
        reg_late <= Din;        
    end

always @(negedge clk_late)begin
    up <= reg_early ^ reg_edge;
    down <= reg_late ^ reg_edge;
end

endmodule