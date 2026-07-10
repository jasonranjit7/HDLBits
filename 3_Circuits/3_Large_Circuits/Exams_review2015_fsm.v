module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    
    reg [2:0] state,nxt_state;
    localparam IDLE=0,S1=1,S11=2,S110=3,S1101=4,COUNT=5,DONE=6;
    
    always@(posedge clk) begin
        if(reset)
            state<=IDLE;
        else
            state<=nxt_state;
    end
    
    reg[1:0] count;
    always@(posedge clk) begin
        if(reset)
            count<=0;
        else if(state == S1101)
            count<=count+1'b1;
    end

    
    always@(*) begin
        case(state)
            IDLE: begin
                if(data)
                    nxt_state = S1;
                else
                    nxt_state = IDLE;
            end
            S1: begin
                if(data)
                    nxt_state = S11;
                else
                    nxt_state = IDLE;
            end
            S11: begin
                if(data)
                    nxt_state = S11;
                else
                    nxt_state = S110;
            end
            S110: begin
                if(data)
                	nxt_state = S1101;
                else
                    nxt_state = IDLE;
            end
            S1101: begin
                if(count!=3)
                	nxt_state = S1101;
                else
                    nxt_state = COUNT;
            end
            COUNT: begin
                if(done_counting)
                    nxt_state = DONE;
                else
                    nxt_state = COUNT;
            end
            DONE:begin
                if(ack)
                    nxt_state=IDLE;
                else
                    nxt_state = DONE;
            end
            default: nxt_state=state;
        endcase
    end
    
    assign shift_ena = state ==S1101;
    assign counting = state==COUNT;
    assign done = state==DONE;
    
                

endmodule

