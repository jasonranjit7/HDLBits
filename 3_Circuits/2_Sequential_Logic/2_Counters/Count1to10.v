module top_module (
    input clk,
    input reset,
    output [3:0] q);
    
    always@(posedge clk) begin
        q<=1'b1;
        if(reset)
            q<=1'b1;
        else if(q<10)
            q<=q+1'b1;
        else
            q<=1'b1;
    end

endmodule

