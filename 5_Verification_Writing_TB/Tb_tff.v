module top_module ();
    reg clk,reset,t;
    wire q;
    
    tff dut(.clk(clk),
            .reset(reset),
            .t(t),
            .q(q)
           );
    
    initial begin
        clk = 0;
        forever #5 clk=~clk;
    end
    
    initial begin
        reset = 1'b1;
        repeat(2)@(negedge clk);
        reset = 0;
        t=1;
    end

endmodule

