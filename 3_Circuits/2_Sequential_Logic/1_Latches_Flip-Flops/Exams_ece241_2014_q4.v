module dff(input d, input clk,
           output reg q);
    always@(posedge clk)
        q<=d;
endmodule

module top_module (
    input clk,
    input x,
    output z
); 
    wire f1,f2,f3;
    dff ff1(.clk(clk),
            .d(x^f1),
            .q(f1)
           );
    dff ff2(.clk(clk),
            .d(x&~f2),
            .q(f2)
           );
    
    dff ff3(.clk(clk),
            .d(x|~f3),
            .q(f3)
           );
    
    assign z = ~(f1|f2|f3);

endmodule

