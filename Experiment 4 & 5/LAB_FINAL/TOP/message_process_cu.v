`define IDLE 1'b0
`define MESSAGE_PROCESSING 1'b1



module message_process_cu (
    input clk, reset,send,co2,
    output reg en_cnt,load_shift_reg,valid
);

    reg  p_state;
    reg  n_state;

    always @(p_state,send,co2) begin
        case(p_state)
            `IDLE:begin
               
                 n_state = send ? `MESSAGE_PROCESSING : `IDLE ; 
            end
                 
            `MESSAGE_PROCESSING:
            begin
                n_state = co2 ? `IDLE : `MESSAGE_PROCESSING ; 
      
            end
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            p_state <= `IDLE;
        else 
            p_state <= n_state;
            
    end


  

   always @(p_state) begin
        case(p_state)
            `IDLE:begin
                en_cnt=0;
                load_shift_reg=1;
                valid=0;
           
            end
                 
            `MESSAGE_PROCESSING:
            begin
                en_cnt=1;
                load_shift_reg=0;
                valid=1;
   
     
            end

        endcase
    end

endmodule



