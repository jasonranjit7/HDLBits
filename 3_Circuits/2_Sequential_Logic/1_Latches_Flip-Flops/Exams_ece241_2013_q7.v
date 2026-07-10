module top_module (
    input clk,
    input j,
    input k,
    output Q);
    
    wire d = (j&~Q)|(~k&Q);
    
    dff jk(.clk(clk),
           .d(d),
           .q(Q)
          );

endmodule

