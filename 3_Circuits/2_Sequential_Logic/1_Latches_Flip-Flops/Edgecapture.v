module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] in_delay;
    always@(posedge clk) begin
        in_delay<=in;
    end
    
    always@(posedge clk) begin
        if(reset)
            out<=0;
        else begin
            for(integer i=0;i<32;i=i+1) begin
                if(!in[i] && in[i]^in_delay[i])
                    out[i] <= 1;
            end
        end
    end
       

endmodule

