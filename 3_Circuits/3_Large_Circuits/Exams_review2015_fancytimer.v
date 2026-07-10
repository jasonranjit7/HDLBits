module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    
    reg [2:0] state,nxt_state;
    localparam IDLE=0,S1=1,S11=2,S110=3,S1101=4,COUNT=5,DONE=6;
    
    //shift reg
    integer delay;
    always@(posedge clk) begin
        if(reset)
            delay<=0;
        else if(state==S1101)
            delay<={delay[2:0],data};
        else if(state==COUNT)
            delay<=delay;
        else
            delay<=0;
    end
    
    reg[1:0] c;
    always@(posedge clk) begin
        if(reset)
            c<=0;
        else if(state == S1101)
            c<=c+1'b1;
        else
            c<=0;
    end
    
    integer cycles;
    //cycles counter
    always@(posedge clk) begin
        if(reset) begin
            cycles<=0;
        end        
        else if(state == COUNT)
            if(cycles<((delay+1'b1)*1000)-1)
                cycles<=cycles+1'b1;
            else begin
                cycles<=0;
                
            end
    end
    
    
    //fsm
    always@(posedge clk) begin
        if(reset)
            state<=IDLE;
        else
            state<=nxt_state;
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
                if(c!=3) begin
                	nxt_state = S1101;
                end
                else begin
                    nxt_state = COUNT;
                end
            end
            COUNT: begin
                if(cycles<((delay+1'b1)*1000)-1)
                    nxt_state = COUNT;
                else
                    nxt_state = DONE;
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
    
    assign done = state==DONE;
    assign counting = state==COUNT;
    assign count = (((delay+1'b1)*1000-1)-cycles)/1000;
endmodule

