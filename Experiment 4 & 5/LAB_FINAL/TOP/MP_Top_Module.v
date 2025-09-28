module MP_Top_Module(input clk , reset ,send,
input [4:0] message,
output ser_out,valid
 );


wire load_shift_reg,en_cnt, co2;

message_process_dp dp_mp(clk, reset, load_shift_reg,en_cnt, message, ser_out, co2);
message_process_cu cu_mp(clk, reset,send,co2, en_cnt, load_shift_reg ,valid );



endmodule



