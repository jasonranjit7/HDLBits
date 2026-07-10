module top_module(
    input clk,
    input areset,    
    input in,
    output out);//  

    parameter A=0, B=1; 
    reg state, nxt_state;

    always @(*) begin    
        nxt_state = state;
        case(state)
            B: begin
                if(in)
                    nxt_state = B;
                else 
                    nxt_state = A;
            end
            A: begin
                if(in)
                    nxt_state = A;
                else
                    nxt_state = B;
            end
            default: nxt_state = state;
        endcase
    end

    always @(posedge clk, posedge areset) begin    
        if(areset)
            state<=B;
        else
            state<=nxt_state;
    end

    assign out = (state == B)?1:0;

endmodule

