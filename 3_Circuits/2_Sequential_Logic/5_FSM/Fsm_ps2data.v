module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
    reg [1:0] state,nxt_state;
    localparam B1=0,B2=1,B3=2,DONE=3;
    
    // State transition logic (combinational)
    always@(*) begin
        case(state)
            B1: begin
                if(in[3])
                    nxt_state<=B2;
                else
                    nxt_state<=B1;
            end
            B2: begin
                nxt_state<=B3;
            end
            B3: begin
                nxt_state<=DONE;
            end
            DONE: begin
                if(in[3])
                    nxt_state<=B2;
                else
                    nxt_state<=B1;
            end
        endcase
    end
            
    
    
    // State flip-flops (sequential)
    always@(posedge clk) begin
        if(reset)
            state<=B1;
        else state<=nxt_state;
    end
    
    // Output logic
    assign done = state==DONE;

    
    reg[7:0] a,b,c;
    // New: Datapath to store incoming bytes.
    always@(posedge clk) begin
        if(reset) begin
            a<=0;
            b<=0;
            c<=0;
        end
        else begin
            if(state == B1|(state == DONE && in[3]))
                a<=in;
            else if(state ==B2)
                b<=in;
            else if(state ==B3)
                c<=in;
        end
    end
    
    
    assign out_bytes = done?{a,b,c}:0;
    

endmodule

