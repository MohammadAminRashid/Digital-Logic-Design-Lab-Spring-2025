module DDS_Top_Module(input clk,reset , output [7:0] sign_mag_to_2s_comp_output);

    wire sign_bit,phase_pose;
    wire [5:0] addr;


	DDS_controller CU(clk, reset,sign_bit,phase_pose,addr);
	DDS_datapath DP(phase_pose, sign_bit,addr, sign_mag_to_2s_comp_output);


endmodule


