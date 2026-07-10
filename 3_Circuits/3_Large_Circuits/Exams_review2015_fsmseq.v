module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    
    reg [2:0] state,nxt_state;
    localparam A=0,B=1,C=2,D=3,E=4;
    
    always@(posedge clk) begin
        if(reset)
            state<=A;
        else
            state<=nxt_state;
    end
    
    always@(*) begin
        case(state)
            A:begin
                if(data)
                    nxt_state=B;
                else nxt_state=A;
            end
            B:begin
                if(data)
                    nxt_state=C;
                else nxt_state=A;
            end
            C:begin
                if(!data)
                    nxt_state=D;
                else nxt_state=C;
            end
            D:begin
                if(data)
                    nxt_state=E;
                else nxt_state=A;
            end
            default: nxt_state = state;
        endcase
    end
    
    assign start_shifting = state==E;

endmodule

