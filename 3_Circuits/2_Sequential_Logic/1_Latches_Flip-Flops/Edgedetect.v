module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    reg [7:0] pdelay1,pdelay;
    always@(posedge clk) begin
        pdelay<=in;
    end
        
    always@(posedge clk) begin
        pedge<=in&~pdelay;
    end

endmodule

