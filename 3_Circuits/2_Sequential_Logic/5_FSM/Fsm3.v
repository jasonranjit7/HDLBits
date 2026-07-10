module top_module(
    input clk,
    input in,
    input areset,
    output out); //

    reg [1:0] state, nxt_state;
    localparam A=0,B=1,C=2,D=3;
    // State transition logic
    always@(*) begin
        case(state)
            A: begin
                if(in)
                    nxt_state = B;
                else nxt_state = A;
            end
            B: begin
                if(in)
                    nxt_state = B;
                else nxt_state = C;
            end
            C: begin
                if(in)
                    nxt_state = D;
                else nxt_state = A;
            end
            D: begin
                if(in)
                    nxt_state = B;
                else nxt_state = C;
            end
        endcase
    end
                
    // State flip-flops with asynchronous reset
    always@(posedge clk or posedge areset) begin
        if(areset)
            state<=A;
        else state<=nxt_state;
    end
    // Output logic
    assign out = state==D;

endmodule

