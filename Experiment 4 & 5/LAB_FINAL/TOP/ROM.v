module ROM(input [5:0]addr ,
output [7:0] out_put);

//reg [7:0] LUT [0:63];

(* romstyle = "M9K" *) (* ram_init_file = "sine.mif" *) reg [7:0] LUT [0:63];

// initial begin
//     //$readmemb( "sine.mem", LUT);
// end

  assign out_put= LUT[addr];


endmodule