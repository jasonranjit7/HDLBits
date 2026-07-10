module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    reg [2:0] state, nxt_state;
    localparam LEFT = 0,RIGHT=1,FALL_L=2,FALL_R=3,DIG_L=4,DIG_R=5;
    
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
                else if(dig)
                    nxt_state = DIG_L;
                else if(bump_left)
                    nxt_state = RIGHT;
                else nxt_state = LEFT;
            end
            RIGHT: begin
                if(!ground)
                    nxt_state = FALL_R;
                else if(dig)
                    nxt_state = DIG_R;
                else if(bump_right)
                    nxt_state = LEFT;
                else nxt_state = RIGHT;
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
            DIG_L: begin
                if(!ground)
                    nxt_state = FALL_L;
                else 
                    nxt_state = DIG_L;
            end
            DIG_R: begin
                if(!ground)
                    nxt_state = FALL_R;
                else 
                    nxt_state = DIG_R;
            end
        endcase
    end
    
    always@(*) begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        case(state)
            LEFT: walk_left = 1'b1;
            RIGHT: walk_right = 1'b1;
            FALL_L: aaah = 1'b1;
            FALL_R: aaah = 1'b1;
            DIG_L: digging = 1'b1;
            DIG_R: digging = 1'b1;
        endcase
    end

endmodule

