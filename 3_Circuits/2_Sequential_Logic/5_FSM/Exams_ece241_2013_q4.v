module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    
    reg [2:0] state,nxt_state;
    reg diff;
    localparam EMPTY = 3'b000, L1 = 3'b001, L2 = 3'b010, L3 = 3'b011,
    		   L1D = 3'b100, L2D = 3'b101;
    
    always@(posedge clk) begin
        if(reset) begin
            state<=EMPTY;
        end
        else
            state<=nxt_state;
    end
    
    always@(*) begin
        case(state)
            EMPTY: begin
                if(s[1]&s[2]&s[3])
                    nxt_state = L3;
                else if(s[1]&s[2]&!s[3])
                    nxt_state = L2;
                else if(s[1]&!s[2]&!s[3])
                    nxt_state = L1;
                else
                    nxt_state = EMPTY;
            end
            L1: begin
                if(s[1]&s[2]&s[3])
                    nxt_state = L3;
                else if(s[1]&s[2]&!s[3])
                    nxt_state = L2;
                else if(s[1]&!s[2]&!s[3])
                    nxt_state = L1;
                else
                    nxt_state = EMPTY;
            end
            L2: begin
                if(s[1]&s[2]&s[3])
                    nxt_state = L3;
                else if(s[1]&s[2]&!s[3])
                    nxt_state = L2;
                else if(s[1]&!s[2]&!s[3])
                    nxt_state = L1D;
                else
                    nxt_state = EMPTY;
            end
            L3: begin
                if(s[1]&s[2]&s[3])
                    nxt_state = L3;
                else if(s[1]&s[2]&!s[3])
                    nxt_state = L2D;
                else if(s[1]&!s[2]&!s[3])
                    nxt_state = L1D;
                else
                    nxt_state = EMPTY;
            end
            L1D: begin
                if(s[1]&s[2]&s[3])
                    nxt_state = L3;
                else if(s[1]&s[2]&!s[3])
                    nxt_state = L2;
                else if(s[1]&!s[2]&!s[3])
                    nxt_state = L1D;
                else
                    nxt_state = EMPTY;
            end
            L2D: begin
                if(s[1]&s[2]&s[3])
                    nxt_state = L3;
                else if(s[1]&s[2]&!s[3])
                    nxt_state = L2D;
                else if(s[1]&!s[2]&!s[3])
                    nxt_state = L1D;
                else
                    nxt_state = EMPTY;
            end
        endcase
    end
    
    always@(*) begin
        case(state)
            EMPTY: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b1;
                dfr = 1'b1;
            end
            L1: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b0;
                dfr = 1'b0;
            end
            L2: begin
                fr1 = 1'b1;
                fr2 = 1'b0;
                fr3 = 1'b0;
                dfr = 1'b0;
            end
            L3: begin
                fr1 = 1'b0;
                fr2 = 1'b0;
                fr3 = 1'b0;
                dfr = 1'b0;
            end
            L1D: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b0;
                dfr = 1'b1;
            end
            L2D: begin
                fr1 = 1'b1;
                fr2 = 1'b0;
                fr3 = 1'b0;
                dfr = 1'b1;
            end
        endcase
    end
                    
                

endmodule

