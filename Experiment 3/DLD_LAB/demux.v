module demux(input SerIn, input [1:0]sel, output reg [3:0] P);

    always @(SerIn, sel) begin

        P = 4'bzzzz;
        case(sel)
            2'b00:
                P[0]=SerIn;
            2'b01:
                P[1]=SerIn;
            2'b10:
                P[2]=SerIn;
            2'b11:
                P[3]=SerIn;
        endcase
        
    end
endmodule
