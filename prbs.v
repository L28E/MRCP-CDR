/*
    Linear Feedback Shift Register generating pseudorandom bit sequence.
    10 bits produces a 1023 long sequence.
    Type I implementation for the primitive polynomial G(x)=x^9+x^6+1.
    0b0001110001 is the initial pattern.
*/

module prbs(input clk,
            input rst,
            output data);

    reg [9:0] reg_shift;
    wire feedback;

    always@(negedge clk or negedge rst) begin
        if (~rst)
            reg_shift <= 10'b0001110001;
        else if (~clk) begin
            reg_shift <= reg_shift << 1;
            reg_shift[0] <= feedback;
        end
    end

    assign feedback = reg_shift[6] ^ reg_shift[9];
    assign data = reg_shift[9];

endmodule