module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    reg [3:0] state,nxt_state;
    localparam A=0,B=1,C=2,D=3,E=4,F=5,G=6,H=7,Z=8;   
    
    
    always@(posedge clk) begin
        if(!resetn)
            state<=A;
        else
            state<=nxt_state;
    end
    
    always@(*) begin
        case(state)
            A: begin
                nxt_state = Z;
            end
            Z: begin
                nxt_state = B;
            end
            B: begin
                if(x)
                    nxt_state = C;
                else
                    nxt_state = B;
            end
            C: begin
                if(!x)
                    nxt_state = D;
                else
                    nxt_state = C;
            end
            D: begin
                if(x)
                    nxt_state = E;
                else
                    nxt_state = B;
            end
            E: begin
                if(y)
                    nxt_state = F;
                else
                    nxt_state = G;
            end
            F: begin
                nxt_state = F;
            end
            G: begin
                if(y)
                    nxt_state = F;
                else
                    nxt_state = H;
            end
            H: begin
                nxt_state = H;
            end
        endcase
    end
    
    assign f = state==Z;
    assign g = state ==E|state==F|state==G;
            
            
    

endmodule

