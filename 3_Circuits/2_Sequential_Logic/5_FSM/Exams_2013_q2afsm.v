module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    
    reg [1:0] state, nxt_state;
    localparam A=0,B=1,C=2,D=3;
    
    always@(posedge clk) begin
        if(!resetn)
            state<=A;
        else state<= nxt_state;
    end
    
    always@(*) begin
        case(state)
            A: begin
                if(r[1])
                    nxt_state = B;
                else if(~r[1]&r[2])
                    nxt_state = C;
                else if(~r[1]&~r[2]&r[3])
                    nxt_state = D;
                else
                    nxt_state = A;
            end
            B: begin
                if(r[1])
                    nxt_state = B;
                else
                    nxt_state = A;
            end
            C: begin
                if(r[2])
                    nxt_state = C;
                else
                    nxt_state = A;
            end
            D: begin
                if(r[3])
                    nxt_state = D;
                else
                    nxt_state = A;
            end
        endcase
    end
    
    assign g = {(state==D),(state==C),(state==B)};

endmodule

