module mux8(input a,b,c,d,e,f,g,h,
            input [2:0] select,
            output reg out);

    always @(a or b or c or d or e or f or g or h or select)begin
        case(select)
            3'b000 : out <= a;
            3'b001 : out <= b;
            3'b010 : out <= c;
            3'b011 : out <= d;
            3'b100 : out <= e;
            3'b101 : out <= f;
            3'b110 : out <= g;
            3'b111 : out <= h;
        endcase
    end

endmodule