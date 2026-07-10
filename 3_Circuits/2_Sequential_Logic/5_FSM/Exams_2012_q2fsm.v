module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    input w,
    output z
);
    reg[2:0] state,nxt_state;
    localparam A=0,B=1,C=2,D=3,E=4,F=5;
    
    always@(posedge clk) begin
        if(reset)
            state<=A;
        else
            state<=nxt_state;
    end
    
    always@(*) begin
        case(state)
            A: begin
                if(w)
                    nxt_state = B;
                else
                    nxt_state = A;
            end
            B: begin
                if(w)
                    nxt_state = C;
                else
                    nxt_state = D;
            end
            C: begin
                if(w)
                    nxt_state = E;
                else
                    nxt_state = D;
            end
            D: begin
                if(w)
                    nxt_state = F;
                else
                    nxt_state = A;
            end
            E: begin
                if(w)
                    nxt_state = E;
                else
                    nxt_state = D;
            end
            F: begin
                if(w)
                    nxt_state = C;
                else
                    nxt_state = D;
            end
            default: nxt_state = state;
        endcase
    end
    
    assign z = state==E| state==F;        
                	
            
        
    

endmodule

