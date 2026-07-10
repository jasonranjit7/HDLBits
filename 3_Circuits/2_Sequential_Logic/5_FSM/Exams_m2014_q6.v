module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);
    
    reg [2:0] state,nxt_state;
    localparam A=0,B=1,C=2,D=3,E=4,F=5;
    
    always@(posedge clk) begin
        if(reset)
            state<=A;
        else 
            state<=nxt_state;
    end
    
    always@(*) begin
        nxt_state = state;
        case(state)
            A: begin
                if(w)
                    nxt_state = A;
                else
                    nxt_state = B;
            end
            B: begin
                if(w)
                    nxt_state = D;
                else
                    nxt_state = C;
            end
            C: begin
                if(w)
                    nxt_state = D;
                else
                    nxt_state = E;
            end
            D: begin
                if(w)
                    nxt_state = A;
                else
                    nxt_state = F;
            end
            E: begin
                if(w)
                    nxt_state = D;
                else
                    nxt_state = E;
            end
            F: begin
                if(w)
                    nxt_state = D;
                else
                    nxt_state = C;
            end
        endcase
    end
    
    assign z = state==E|state==F;

endmodule

