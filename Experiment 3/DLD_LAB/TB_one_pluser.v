
`timescale 1ns/1ns
module TB_one_pluser ();
    
    reg clk;
    reg clkPB;
    wire clkEN;
    reg reset;


    one_pluser  one_pluser_uut(clk,clkPB, reset,clkEN);
    
    always #5 clk=~clk;
    initial begin 
        clk=0;
        clkPB=0;
        reset=1;
        #1 reset=0;


        #20 clkPB=1;


        #30 clkPB = 0 ;

        
        #10 clkPB=1;


        #30 clkPB = 0 ;



        #50;
    $stop;


    end


endmodule
