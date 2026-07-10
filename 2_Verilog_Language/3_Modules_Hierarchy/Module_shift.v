module top_module ( input clk, input d, output q );
    
    wire f1,f2;
    
    my_dff ff1(.clk(clk),
               .d(d),
               .q(f1)
              );
    my_dff ff2(.clk(clk),
               .d(f1),
               .q(f2)
              );
    my_dff ff3(.clk(clk),
               .d(f2),
               .q(q)
              );
    
               

endmodule

