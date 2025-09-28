`define IDLE 2'b00
`define PORT_NUMBER 2'b01
`define DATA_NUMBER 2'b10
`define DATA_TRANSFER 2'b11


module  controller (input clk, reset, clkEN,SerIn, co1, co2, coD , 
output reg clear, cnt1, cnt2, cntD, ld_cntD, sh_en, sh_enD, serOut_valid, done);
    
    reg [1:0]p_state;
    reg [1:0]n_state;

    reg clk_enable_d;



    always @(p_state,co1,co2,coD,SerIn) begin
           
           case(p_state)
           `IDLE: 
             n_state<=SerIn? `IDLE : `PORT_NUMBER;
           
           `PORT_NUMBER:
                   begin
                n_state<= co1? `DATA_NUMBER : `PORT_NUMBER ;
                sh_en<=~co1;
                   end
           `DATA_NUMBER:
              begin
             n_state<= co2? `DATA_TRANSFER : `DATA_NUMBER;
             ld_cntD<=co2? 1:0; 
             sh_enD<=~co2;
              end 

            `DATA_TRANSFER:
            begin
             n_state<=coD? `IDLE : `DATA_TRANSFER;    
             done<=coD?  1:0;
            end
               
           endcase
        
    end

    always @(posedge clk or posedge reset) begin

      if(reset)
         p_state<=`IDLE;
      else if (clkEN)
         p_state<=n_state;
    end

    always @(p_state) begin

         {clear, cnt1, cnt2, cntD, ld_cntD, sh_en, sh_enD, serOut_valid, done}=10'b0000000000;
         case(p_state)
           `IDLE: 
            clear<=1;
           `PORT_NUMBER:
           begin
              cnt1<=1;
              sh_en<=1;

           end
           `DATA_NUMBER:
           begin
              cnt2<=1;
              sh_enD<=1;
           end

           `DATA_TRANSFER:
           begin
              cntD<=1;
              serOut_valid<=1;
           end

            
           endcase
        
    end



endmodule
