module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

	localparam A=1'b1, B=1'b0;
    reg state, nxt_state;

    always@(posedge clk) begin
        if(reset)
            state<=B;
        else
            state<=nxt_state;
    end
    
    always@(*) begin
        case(state)
            B: begin
                if(in)
                    nxt_state = B;
                else
                    nxt_state = A;
            end
            A: begin
                if(in)
                    nxt_state = A;
                else
                    nxt_state = B;
            end
            default: nxt_state = state;
        endcase
    end
    
    always@(*) begin
        case(state)
            B: out = 1'b1;
            A: out = 1'b0;
            default: out = 1'b0;
        endcase
    end
        
                
            

endmodule

