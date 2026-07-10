module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    reg [1:0] state,nxt_state;
    localparam S0=0,S1=1,S2=2;        
                
    always@(posedge clk or posedge areset) begin
        if(areset)
            state<=S0;
        else
            state<=nxt_state;
    end
    
    always@(*) begin
        nxt_state = state;
        case(state)
            S0: begin
                if(!x)
                    nxt_state = S0;
                else
                    nxt_state = S1;
            end
            S1: begin
                if(x)
                    nxt_state = S2;
                else 
                    nxt_state =S1;
            end
            S2: begin
                if(x)
                    nxt_state = S2;
                else
                    nxt_state = S1;
            end
            default: nxt_state = S0;
        endcase
    end
    
    assign z = state==S1;

endmodule

