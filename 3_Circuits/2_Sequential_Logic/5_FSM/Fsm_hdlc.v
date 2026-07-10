module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    reg[2:0] state,nxt_state;
    localparam IDLE=0,DATA=1,DISC=2,ERR=3,FLAG=4;
    
    reg[3:0] data_count;
    always@(posedge clk) begin
        if(reset)
            data_count<=0;
        else if(in)
            	data_count<=data_count+1'b1;
        else
            data_count<=0;
    end
    
    always@(posedge clk) begin
        if(reset)
            state<=DATA;
        else
            state<=nxt_state;
    end
    
    always@(*) begin
        nxt_state = state;
        case(state)
            IDLE: begin
                if(in)
                    nxt_state = DATA;
                else
                    nxt_state = IDLE;
            end
            DATA: begin
                if(in) begin
                    if(data_count>=6)
                        nxt_state = ERR;
                    else
                        nxt_state = DATA;
                end
                else begin
                    if(data_count == 6)
                        nxt_state = FLAG;
                    else if(data_count == 5)
                        nxt_state = DISC;
                    else
                        nxt_state = DATA;
                end
            end
            DISC: begin
                nxt_state = IDLE;
            end
            ERR: begin
                if(!in)
                    nxt_state = IDLE;
                else
                    nxt_state = ERR;
            end
            FLAG: begin
               nxt_state = IDLE;
            end
            default: nxt_state = IDLE;
        endcase
    end
    
    assign err = state==ERR;
    assign flag = state==FLAG;
    assign disc = state==DISC;
        
                    

endmodule

