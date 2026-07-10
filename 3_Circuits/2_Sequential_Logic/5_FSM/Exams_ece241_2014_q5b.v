module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    reg[1:0] state,nxt_state;

    always@(posedge clk or posedge areset) begin
        if(areset)
            state<=1;
        else
            state<=nxt_state;
    end
    
    assign nxt_state[0] = state[0]& ~x;
    assign nxt_state[1] = state[0]& x | state[1];
    
    assign z = (state[0] && x==1'b1 || state[1] && x==1'b0);

endmodule

