module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    
    wire [3:0]f;
    
    always@(posedge clk) begin
        if(!resetn)
            f<=0;
        else begin
            f[3]<=in;
            f[2]<=f[3];
            f[1]<=f[2];
            f[0]<=f[1];
        end
    end
    
    assign out = f[0];
            

endmodule

