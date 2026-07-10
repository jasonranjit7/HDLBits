module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 
    
    always@(posedge clk) begin
        if(load)
            q<=data;
        else begin
            q[511]<=1'b0^q[510];
            q[510:1]<=q[511:2]^q[509:0];
            q[0]<=q[1]^1'b0;
        end
    end

endmodule

