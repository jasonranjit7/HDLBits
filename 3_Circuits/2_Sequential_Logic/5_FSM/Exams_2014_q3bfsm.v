module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    
    reg [2:0] state, nxt_state;
    localparam A=0,B=1,C=2,D=3,E=4;
    
    always@(posedge clk) begin
        if(reset)
            state<=A;
        else
            state<=nxt_state;
    end
    
    always@(*) begin
        case(state)
            A: begin
                if(x)
                    nxt_state = B;
                else
                    nxt_state = A;
            end
            B: begin
                if(x)
                    nxt_state = E;
                else
                    nxt_state = B;
            end
            C: begin
                if(x)
                    nxt_state = B;
                else
                    nxt_state = C;
            end
            D: begin
                if(x)
                    nxt_state = C;
                else
                    nxt_state = B;
            end
            E: begin
                if(x)
                    nxt_state = E;
                else
                    nxt_state = D;
            end
        endcase
    end
    
    assign z = (state ==E)||(state==D);

endmodule

