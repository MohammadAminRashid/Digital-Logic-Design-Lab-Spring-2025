module  DDS_datapath (
input phase_pose, sign_bit,
input [5:0] addr,
output[7:0] sign_mag_to_2s_comp_output
);

wire sign_mag_to_2s_comp_input_select, addr_cout;
wire [5:0] addr_2s_comp, rom_input ;
wire[7:0] rom_output, sign_mag_to_2s_comp_input ;



ROM sine_rom(rom_input,rom_output);


assign addr_cout = ~(|addr);
assign sign_mag_to_2s_comp_input_select = phase_pose & addr_cout;

mux2to1 #(6) mux1( addr,addr_2s_comp, phase_pose ,rom_input);
mux2to1 #(8) mux2( rom_output, 8'b11111111 , sign_mag_to_2s_comp_input_select ,sign_mag_to_2s_comp_input);


twos_comp #(6) tcomp(addr,addr_2s_comp);
sign_mag_to_2s_comp #(8) sign_mag_tcomp(sign_mag_to_2s_comp_input,sign_bit ,sign_mag_to_2s_comp_output);


    
endmodule