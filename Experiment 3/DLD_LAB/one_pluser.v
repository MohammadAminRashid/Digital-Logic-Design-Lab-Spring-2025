`define IDLE 2'b00
`define PULSE 2'b01
`define WAIT 2'b10


module  one_pluser (input clk, input clkPB, input reset , output reg clkEN );
    
    reg [1:0]p_state;
    reg [1:0]n_state;
    always @(p_state,clkPB) begin
           
           case(p_state)
           `IDLE: 
             n_state<=clkPB? `PULSE : `IDLE;
           
           `PULSE:

                n_state<= `WAIT;
           `WAIT:
             n_state<=clkPB? `WAIT : `IDLE;
            
           endcase
        
    end

    always @(posedge clk or posedge reset) begin

       if(reset)
         p_state<=`IDLE;
        else
          p_state<=n_state;
    end

    always @(p_state ) begin
         case(p_state)
           `IDLE: 
            clkEN<=0;
           `PULSE:
              clkEN<=1;
           `WAIT:
              clkEN<=0;
            
           endcase
        
    end


endmodule
