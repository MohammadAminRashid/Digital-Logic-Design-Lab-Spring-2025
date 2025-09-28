module MSSD(
    input clk,reset,clkPB,SerIn,
    output serOut_valid,done,
    output [6:0] SSD_OUT_LOW,
    output [6:0] SSD_OUT_HIGH,
    output [3:0] P
);
wire clear;

one_pluser One_Pluser(clk,clkPB,reset ,clkEN);
data_path DP(clk,reset,clkEN,sh_en,sh_enD,SerIn,cnt1,cnt2,cntD,ld_cntD,co1,co2,coD,SSD_OUT_LOW,SSD_OUT_HIGH,P);
controller CU(clk,reset,clkEN,SerIn,co1,co2,coD ,clear, cnt1, cnt2, cntD, ld_cntD, sh_en, sh_enD, serOut_valid, done);


endmodule