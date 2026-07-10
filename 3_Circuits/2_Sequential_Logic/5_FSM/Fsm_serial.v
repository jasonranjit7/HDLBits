module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    reg [2:0] state, nxt_state;
    localparam START=0,DATA=1,STOP=2,DONE=3,WAIT = 4;
    
    always@(posedge clk) begin
        if(reset)
            state<= START;
        else
            state<= nxt_state;
    end
    
    //data bit counter
    reg [2:0] data_count;
    always@(posedge clk) begin
        if(reset)
            data_count<= 0;
        else if(state == DATA)
            data_count<=data_count+1'b1;
        else
            data_count<=0;
    end
    
    
    
    always@(*) begin
        case(state)
            START:begin
                if(!in)
                    nxt_state = DATA;
                else
                    nxt_state = START;
            end
            DATA: begin
                if(data_count<7)
                    nxt_state = DATA;
                else nxt_state = STOP;
            end
            STOP: begin
                if(in)
                    nxt_state = DONE;
                else
                    nxt_state = WAIT;
            end
            DONE: begin
                if(in)
                    nxt_state = START;
                else
                    nxt_state = DATA;
            end
            
            WAIT: begin
                if(in)
                    nxt_state = START;
                else 
                    nxt_state = WAIT;
            end
            default: nxt_state = START;
        endcase
    end
    
    assign done = state==DONE;
                    

endmodule

