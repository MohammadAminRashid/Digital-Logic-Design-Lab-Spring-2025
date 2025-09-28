module freq_divider(
input clk, reset, init, select ,
input [2:0] cnt  ,
output dds_clk,co1
);


wire [8:0] A,B;
wire co2;
wire load1,load2;


assign load1= init? 1: co1;
assign load2= init? 1: co2;



counter #(9) freq_div1( clk, reset,load1,1, {1'b1,cnt,5'b00000} ,9'b111111111,co1,A);


counter #(9) frq_div2( clk, reset,load2,1, {1'b0,cnt,5'b00000} ,9'b111111111,co2,B);


mux2to1 #(9) clkmux(co2 ,co1 ,select ,dds_clk );

endmodule



















