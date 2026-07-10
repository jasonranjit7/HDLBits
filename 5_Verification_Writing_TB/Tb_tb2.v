module top_module();
    reg clk,in;
    reg [2:0] s;
    wire out;
    
    initial begin
        clk = 0;
        forever #5 clk=~clk;
    end
    
    q7 dut(.clk(clk),
           .in(in),
           .s(s),
           .out(out)
          );
    
    initial begin
        in=0;
        s=3'd2;
        @(negedge clk)
        s=3'd6;
        @(negedge clk)
        s=3'd2;
        in=1;
        @(negedge clk)
        s=3'd7;
        in=0;
        @(negedge clk)
        s=3'd0;
        in=1;
        repeat(3)@(negedge clk);
        in=0;
    end
    

endmodule

