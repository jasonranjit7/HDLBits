module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    
    reg state, nxt_state;
    localparam A=0,B=1;
    
    always@(posedge clk) begin
        if(reset)
            state<=A;
        else state<= nxt_state;
    end
    
    always@(*) begin
        case(state)
            A: begin
                if(s)
                    nxt_state = B;
                else 
                    nxt_state = A;
            end
            B: nxt_state = B;
        endcase
    end
    
    reg [1:0] cycle_count,w_count;
    always@(posedge clk) begin
        if(reset) begin
            cycle_count<=0;
            w_count<=0;
        end
        else if(state == A) begin
            cycle_count<=0;
            w_count<=0;
            end
        else if(state == B) begin
            if(cycle_count == 2'd2) begin
            	cycle_count<=0;
            end
            else
                cycle_count<=cycle_count+1'b1;
            if(cycle_count == 2'b0)
                w_count<=w;
            else
                w_count<=w_count+w;
        end
    end
    assign z = (state == B && cycle_count == 2'd0 && w_count == 2'd2);

endmodule

