module pwm_8bit (
    input  clk,           
    input  rst,           
    input  [7:0] duty,     
    output reg pwm_out        
);

    reg [7:0] counter;

    always @(posedge clk or posedge rst) begin
        if (rst)
            counter <= 8'd0;
        else
            counter <= counter + 1;
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            pwm_out <= 1'b0;
        else
            pwm_out <= (counter < duty);
    end

endmodule