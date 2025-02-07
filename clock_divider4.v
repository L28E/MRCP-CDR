/* 
    Divides the clock frequency by 4
*/
module clock_divider4 (input clk_in,
                       input rst,
                       output clk_out);

reg [2:0] count;
assign clk_out = count[2];

always @(negedge clk_in or negedge rst)
    if (~rst)
        count <= 3'b000;            
    else
        count <= (count == 7) ? 3'b000: count + 1;
endmodule