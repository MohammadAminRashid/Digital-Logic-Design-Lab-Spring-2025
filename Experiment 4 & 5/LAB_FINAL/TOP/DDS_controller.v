`define FIRST_QUARTER 2'b00
`define SECOND_QUARTER 2'b01
`define THIRD_QUARTER 2'b10
`define FOURTH_QUARTER 2'b11


module DDS_controller (
    input clk, reset,
    output reg sign_bit,phase_pose,
    output [5:0] addr
);


    wire co;
    reg [1:0] p_state;
    reg [1:0] n_state;

    counter #(6) cnt6( clk, reset,0,1,6'b000000,6'b111111,co,addr);

    always @(p_state,co) begin
        case(p_state)
            `FIRST_QUARTER:begin
               
                 n_state = co ? `SECOND_QUARTER : `FIRST_QUARTER ; 
            end
                 
            `SECOND_QUARTER:
            begin
                n_state = co ? `THIRD_QUARTER : `SECOND_QUARTER ; 
      
            end

            `THIRD_QUARTER:
            begin
                 n_state = co ? `FOURTH_QUARTER : `THIRD_QUARTER ; 
    

            end

            `FOURTH_QUARTER:begin
                 n_state = co ? `FIRST_QUARTER : `FOURTH_QUARTER ; 

            end
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            p_state <= `FIRST_QUARTER;
        else 
            p_state <= n_state;
            
    end


  

   always @(p_state) begin
        case(p_state)
            `FIRST_QUARTER:begin
               sign_bit = 0 ;
               phase_pose = 0 ;
            end
                 
            `SECOND_QUARTER:
            begin
                 sign_bit = 0 ;
               phase_pose = 1 ;
            end

            `THIRD_QUARTER:
            begin
                  sign_bit = 1 ;
               phase_pose = 0 ;
            end

            `FOURTH_QUARTER:begin
                 sign_bit = 1 ;
               phase_pose = 1 ;
            end
        endcase
    end

endmodule
