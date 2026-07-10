module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    wire [7:0]pdelay;
    always@(posedge clk) begin
        pdelay<=in;
        anyedge <= in^pdelay;
    end
        

endmodule

