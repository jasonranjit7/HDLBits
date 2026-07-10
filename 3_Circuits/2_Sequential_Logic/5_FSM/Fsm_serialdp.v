module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Modify FSM and datapath from Fsm_serialdata
	reg [2:0] state, nxt_state;
    localparam START=0,DATA=1,STOP=2,DONE=3,WAIT = 4,PARITY=5;
    
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
                else nxt_state = PARITY;
            end
            PARITY: begin
                if(odd^in)
                    nxt_state = STOP;
                else
                    nxt_state = WAIT;
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
    
    // New: Datapath to latch input bits.
    reg [7:0] data;
    always@(posedge clk) begin
        if(reset)
            data<=0;
        else if(state == DATA)
            data<={in,data[7:1]};
        else
            data<=data;
    end
    
    assign out_byte = done?data:0;
    // New: Add parity checking.
    reg odd;
    always @(posedge clk) begin
        if (reset) 
            odd <= 0;
        else if (state ==DATA)
            if(in)
            	odd <= ~odd;
            else 
                odd<=odd;
        else
            odd<=0;
    end

endmodule

