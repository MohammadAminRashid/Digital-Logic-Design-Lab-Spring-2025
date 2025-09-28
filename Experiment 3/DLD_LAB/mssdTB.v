`timescale 1ns/1ns
module MSSD_TB ();
    
    reg clk, reset, SerIn, clkPB;
    wire [3:0] P;
    wire done, serOut_valid;
    wire [6:0] SSD_OUT_LOW;
    wire [6:0] SSD_OUT_HIGH;

    MSSD mssd_utt(
        .clk(clk),
        .reset(reset),
        .clkPB(clkPB),
        .SerIn(SerIn),
        .serOut_valid(serOut_valid),
        .done(done),
        .SSD_OUT_LOW(SSD_OUT_LOW),
        .SSD_OUT_HIGH(SSD_OUT_HIGH),
        .P(P)
    );
    
    always #5 clk = ~clk;

    task initialize;
    begin
        $display("Initialization started at time = %t", $time);
        SerIn = 1;
        clk = 0;
        clkPB = 0;
        reset = 1;
        #1 reset = 0;
        $display("Initialization completed at time = %t", $time);
    end
    endtask

    task send_bit;
        input bit_value;
        begin
            SerIn = bit_value;
            #50;  
        end
    endtask

    task pulse_clkPB;
    begin
        #10 clkPB = 1;
        #20 clkPB = 0;
    end
    endtask

    task send_first_sequence;
    begin
        $display("Port number transmission at time = %t", $time);
        
        send_bit(0); pulse_clkPB(); // Start bit
        send_bit(1); pulse_clkPB();
        send_bit(0); pulse_clkPB();
 
        $display("Port number completed at time = %t", $time);
    end
    endtask

    task send_second_sequence;
    begin
        $display("Data number transmission at time = %t", $time);
        
        send_bit(0); pulse_clkPB(); 
        send_bit(1); pulse_clkPB();
        send_bit(0); pulse_clkPB();
        send_bit(1); pulse_clkPB();
        send_bit(0); pulse_clkPB();
        send_bit(1); pulse_clkPB();
                
        $display("Data number completed at time = %t", $time);
    end
    endtask

    task send_end_sequence;
    begin
        $display("Transfer number transmission at time = %t", $time);

        send_bit(1); pulse_clkPB();
        send_bit(0); pulse_clkPB();
        send_bit(1); pulse_clkPB();
        send_bit(0); pulse_clkPB();
        send_bit(0); pulse_clkPB();
        send_bit(1); pulse_clkPB();
        send_bit(1); pulse_clkPB();
        send_bit(1); pulse_clkPB();
        send_bit(1); pulse_clkPB();
        send_bit(0); pulse_clkPB();
        send_bit(0); pulse_clkPB();
        send_bit(0); pulse_clkPB();
        send_bit(1); pulse_clkPB();
        send_bit(1); pulse_clkPB();
        send_bit(1); pulse_clkPB();
        send_bit(1); pulse_clkPB();
        send_bit(1); pulse_clkPB();
        send_bit(1); pulse_clkPB();
        send_bit(0); pulse_clkPB();
        send_bit(0); pulse_clkPB();
        send_bit(0); pulse_clkPB();
        SerIn = 1;
        repeat(4) begin
            #10 clkPB = 1;
            #20 clkPB = 0;
        end
        $display("Transfer number completed at time = %t", $time);
    end
    endtask

    initial begin
        $display("Starting MSSD Testbench");
        
        initialize();
        send_first_sequence();
        send_second_sequence();
        send_end_sequence();
        
        #500;
        $display("MSSD Testbench completed");
        $stop;
    end

endmodule



