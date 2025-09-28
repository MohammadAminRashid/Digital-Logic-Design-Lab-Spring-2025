module data_path(
    input clk,reset,clkEN,sh_en,sh_enD,SerIn,cnt1,cnt2,cntD,ld_cntD,
    output co1,co2,coD,
    output [6:0] SSD_OUT_LOW,
    output [6:0] SSD_OUT_HIGH,
    output [3:0] P
);

wire[1:0] port_num;
wire[4:0] num_data;
wire [1:0] cnt_port;
wire [2:0] cnt_data_num;
wire [4:0] data_trans;
wire [3:0] tens;
wire [3:0] units;

shift_register #(2) port_num_sh(clk , reset , clkEN,sh_en, SerIn, port_num);
shift_register #(5) data_num_sh(clk , reset , clkEN,sh_enD , SerIn,num_data );

counter #(2) counter1(clk, reset,clkEN,0,cnt1,00,1,10,co1 , cnt_port );

counter #(3) counter2(clk, reset,clkEN,0,cnt2,000,1,101,co2, cnt_data_num);

counter #(5) counterD(clk, reset,clkEN,ld_cntD,cntD,num_data,0,00000,coD,data_trans);

demux dmux(SerIn,port_num,P);

assign tens  = data_trans / 10;
assign units = data_trans % 10;

Seven_Segment SSDlow(units, SSD_OUT_LOW);
Seven_Segment SSDhigh(tens , SSD_OUT_HIGH);



endmodule