module filter(input in_p,
              input in_n,
              input clk,
              input rst,
              output out_p,
              output out_n);

    wire or_p;
    wire or_n;

    reg [3:0] reg_p_samples;
    reg [3:0] reg_n_samples;

    always@(posedge clk or negedge rst) 
        if (~rst) begin
            reg_p_samples <= 4'b0000;
            reg_n_samples <= 4'b0000;
        end
        else begin
            reg_p_samples <= reg_p_samples << 1;
            reg_n_samples <= reg_n_samples << 1;            
            reg_p_samples[0] <= in_p;
            reg_n_samples[0] <= in_n;
        end

    assign or_p = |reg_p_samples;
    assign or_n = |reg_n_samples;
    assign out_p = or_p && ~or_n;
    assign out_n = or_n && ~or_p;   

endmodule