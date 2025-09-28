module counter #(parameter N=2)(  
    input clk,reset,clkEN,load,en,
    input[N-1:0] par_load,
    input direction,
    input [N-1:0]upper_bound,
    output co,
    output reg [N-1:0] W 
);

always @(posedge clk or posedge reset) begin
   if(reset)
        W<={N{1'b0}};
   
   else if(load && clkEN)
        W<=par_load;
   
   else if(en && clkEN && direction)
        W<=W+1;
   else if(en && clkEN && ~direction)
        W<=W-1;
   
end

   assign co = (W==upper_bound) ? 1 : 0 ;
endmodule
