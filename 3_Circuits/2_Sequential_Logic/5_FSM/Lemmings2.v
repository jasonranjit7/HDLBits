module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    reg [1:0] state,nxt_state;
    localparam LEFT=0, RIGHT=1, FALL_L=2, FALL_R=3;
    
    always@(posedge clk or posedge areset) begin
        if(areset)
            state<=LEFT;
        else
            state<=nxt_state;
    end
    
    always@(*) begin
        case(state)
            LEFT: begin
                if(!ground)
                    nxt_state = FALL_L;
                else if(bump_left)
                    nxt_state = RIGHT;
                else
                    nxt_state = LEFT;
            end
            RIGHT: begin
                if(!ground)
                    nxt_state = FALL_R;
                else if(bump_right)
                    nxt_state = LEFT;
                else
                    nxt_state = RIGHT;
            end
            FALL_L: begin
                if(ground)
                    nxt_state = LEFT;
                else 
                    nxt_state = FALL_L;
            end
            FALL_R: begin
                if(ground)
                    nxt_state = RIGHT;
                else
                    nxt_state = FALL_R;
            end
        endcase
    end
    
    always@(*) begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        case(state)
            LEFT: walk_left = 1'b1;
            RIGHT: walk_right = 1'b1;
            FALL_L: begin
                aaah = 1'b1;
            end
            FALL_R: begin
                aaah = 1'b1;
            end
        endcase
    end
endmodule

