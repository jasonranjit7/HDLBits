module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    
    reg [2:0] state, nxt_state;
    localparam A=0,B=1,C=2,D=3,E=4;
    
    always@(posedge clk) begin
        state<=nxt_state;
    end
    
    always@(*) begin
        case(y)
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
    
    assign z = (y == E)||(y==D);
    assign Y0 = nxt_state[0];

endmodule

