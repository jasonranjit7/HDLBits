module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=1'b0, ON=1'b1; 
    reg state, nxt_state;

    always @(*) begin
        nxt_state = state;
        
        case(state)
            OFF: begin
                if(j)
                    nxt_state = ON;
                else
                    nxt_state = OFF;
            end
            ON: begin
                if(k)
                    nxt_state = OFF;
                else
                    nxt_state = ON;
            end
        endcase
    end

    always @(posedge clk, posedge areset) begin
        
        if(areset)
            state<=OFF;
        else
            state<=nxt_state;
    end
    
    assign out = (state == OFF)?1'b0:1'b1;

endmodule

