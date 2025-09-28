module message_process_dp(
input clk, reset, load_shift_reg,en_cnt,
input [4:0] message,
output ser_out,co2
);
wire co1;
wire [3:0] message_cnt;
wire [9:0] sin_cnt;
counter #(4)  cnt4( clk, reset,0,co1, 4'b0 ,4'b1001,co2, message_cnt);
counter #(10) cnt5( clk, reset,0,en_cnt,10'b0 ,10'b1111111111,co1, sin_cnt);


shift_register #(9) sr(clk, reset, co1 , load_shift_reg, message,ser_out);


endmodule