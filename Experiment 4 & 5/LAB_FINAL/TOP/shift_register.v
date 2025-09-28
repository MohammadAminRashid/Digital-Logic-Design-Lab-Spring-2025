module shift_register #(parameter N=9)(
    input clk, reset, shift, load,
    input [4:0] message,
    output reg ser_out
);
    reg [8:0] W;

    always @(posedge clk or posedge reset) begin 
        ser_out<=W[8];
        if (reset) begin
            W <= 9'b010100000;
        end else if (load) begin
            W <= {4'b0101, message};
        end else if (shift) begin
            ser_out <= W[8];
            W <= {W[7:0], 1'b0};
        end
    end
endmodule