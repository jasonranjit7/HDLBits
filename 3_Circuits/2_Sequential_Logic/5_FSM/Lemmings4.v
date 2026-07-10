module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging ); 
    
    reg [2:0] state,nxt_state;
    localparam LEFT=0,RIGHT=1,FALL_L=2,FALL_R=3,DIG_L=4,DIG_R=5,SPLAT=6;
    reg reset_count,splat=0;
    reg [31:0] fall_count;
    
    always@(posedge clk or posedge areset) begin
        if(areset)
            fall_count<=0;
        else if(state == FALL_L| state == FALL_R)
            fall_count<=fall_count+1'b1;
        else 
            fall_count<=0;
    end
    
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
                    nxt_state<=FALL_L;
                else if(dig)
                    nxt_state<=DIG_L;
                else if(bump_left)
                    nxt_state<=RIGHT;
                else nxt_state<=LEFT;
            end
            RIGHT: begin
                if(!ground)
                    nxt_state<=FALL_R;
                else if(dig)
                    nxt_state<=DIG_R;
                else if(bump_right)
                    nxt_state<=LEFT;
                else nxt_state<=RIGHT;
            end
            FALL_L: begin
                if(!ground)
                    nxt_state<=FALL_L;
                else if(fall_count>19)
                    nxt_state<=SPLAT;
                else
                    nxt_state<=LEFT;
            end
            FALL_R: begin
                if(!ground)
                    nxt_state<=FALL_R;
                else if(fall_count>19)
                    nxt_state<=SPLAT;
                else
                    nxt_state<=RIGHT;
            end
            DIG_L: begin
                if(!ground)
                    nxt_state<=FALL_L;
                else
                    nxt_state<=DIG_L;
            end
            DIG_R: begin
                if(!ground)
                    nxt_state<=FALL_R;
                else
                    nxt_state<=DIG_R;
            end
            SPLAT: nxt_state<=SPLAT;
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
            FALL_L: begin
                aaah = 1'b1;
            end
            FALL_R: begin
                aaah = 1'b1;
            end
            DIG_L: digging = 1'b1;
            DIG_R: digging = 1'b1;
            SPLAT: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end
        endcase
    end
            
            

endmodule

