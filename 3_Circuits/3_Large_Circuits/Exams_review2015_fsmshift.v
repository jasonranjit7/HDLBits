module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    reg[2:0] count;
    //enable counter
    always@(posedge clk) begin
        if(reset)
            count<=0;
        else if(count!=4)
            count<=count+1'b1;
        else if(count==4)
            count<=count;
    end
    
    assign shift_ena = count!=4;

endmodule

