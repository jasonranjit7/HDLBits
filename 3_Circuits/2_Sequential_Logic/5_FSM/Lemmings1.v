module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    parameter LEFT=0, RIGHT=1;
    reg state, nxt_state;

    always @(*) begin
        case(state)
            LEFT: begin
                if(bump_left)
                    nxt_state = RIGHT;
                else
                    nxt_state = LEFT;
            end
            RIGHT: begin
                if(bump_right)
                    nxt_state = LEFT;
                else
                    nxt_state = RIGHT;
            end
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset)
            state<=LEFT;
        else
            state<=nxt_state;
            
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);

endmodule

