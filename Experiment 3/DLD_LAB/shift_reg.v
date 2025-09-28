module shift_register #(parameter N=4)(
    input clk, reset,clkEN,en,SerIn,
    output reg [N-1:0] W
);

    always @(posedge clk) begin 
        if (reset) 
            W <= {N{1'bz}};
        else if (en && clkEN) 
            W<= {W[N-2:0],SerIn};
    end
endmodule
