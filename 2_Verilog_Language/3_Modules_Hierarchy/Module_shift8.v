module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output reg [7:0] q 
);
    wire [7:0] f1,f2,f3;
    
    my_dff8 ff1(.clk(clk),
                .d(d),
                .q(f1)
               );
    
    my_dff8 ff2(.clk(clk),
                .d(f1),
                .q(f2)
               );
    my_dff8 ff3(.clk(clk),
                .d(f2),
                .q(f3)
               );
    always@(*) begin
        case(sel)
            2'b00: q = d;
            2'b01: q = f1;
            2'b10: q = f2;
            2'b11: q = f3;
        endcase
    end
endmodule

