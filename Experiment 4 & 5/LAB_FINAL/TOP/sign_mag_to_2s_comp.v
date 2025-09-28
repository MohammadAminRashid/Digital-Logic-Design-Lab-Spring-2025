module sign_mag_to_2s_comp #(parameter N = 8) (
    input [N-1:0] A,
    input sign_bit,               
    output [N-1:0] Y     
);
    assign Y = sign_bit ? (~A)+1 : A ; 
endmodule

