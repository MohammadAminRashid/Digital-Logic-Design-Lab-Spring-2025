module counter #(parameter N=6)(  
    input clk,reset,load,en,
    input[N-1:0] par_load,
    input[N-1:0] upper_bound,
    output co,
    output reg [N-1:0] W 
);

always @(posedge clk or posedge reset) begin
   if(reset)begin
        W<={N{1'b0}};
        
   end
   
   else if(load)
        W<=par_load;
   
   else if(en)
        W<=W+1;

   
end

   assign co = (W==upper_bound) ? 1 : 0 ;
endmodule
