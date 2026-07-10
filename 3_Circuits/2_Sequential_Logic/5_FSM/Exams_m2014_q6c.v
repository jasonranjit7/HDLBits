module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);
    
    
    reg[6:1] nxt_state;
    
    assign nxt_state[1] = (y[1]&w)|(y[4]&w);
    assign nxt_state[2] = (y[1]&~w);
    assign nxt_state[3] = (y[2]&~w)|(y[6]&w);
    assign nxt_state[4] = (y[2]&w)|(y[3]&w)|(y[5]&w)|(y[6]&w);
    assign nxt_state[5] = (y[5]&~w)|(y[3]&~w);
    assign nxt_state[6] = (y[4]&~w);
    
    assign Y2 = nxt_state[2];
    assign Y4 = nxt_state[4];
    

endmodule

