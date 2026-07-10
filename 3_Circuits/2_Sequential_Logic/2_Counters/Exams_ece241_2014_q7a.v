module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); //
    always @(*) begin
        c_d = 4'd1;         // default
        c_load = 0;         // default
        if (reset) begin
            c_load   = 1;
            c_enable = 0;
        end
        else if (!enable) begin
            c_load   = 0;
            c_enable = 0;
        end
        else begin
            c_enable = 1;
            if (Q==12)
                c_load = 1;
        end
    end

    count4 the_counter (clk, c_enable, c_load, c_d,Q);
    
    

endmodule

