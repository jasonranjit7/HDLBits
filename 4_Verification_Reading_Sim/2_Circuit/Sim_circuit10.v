module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
    
    reg nxt;
    
    always@(posedge clk)
        state<=nxt;
    
    always@(*) begin
        case({a,b})
            2'b00: nxt = 0;
            2'b01: nxt = state;
            2'b10: nxt = state;
            2'b11: nxt = 1'b1;
            default: nxt = 0;
        endcase
    end
    
    assign q = a^b^state;
            
        

endmodule

