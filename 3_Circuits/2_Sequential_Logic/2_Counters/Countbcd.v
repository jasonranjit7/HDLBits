module bcd (
    input clk,
    input reset, // Synchronous active-high reset
    input enable,
    output [3:0] q);
    
    always@(posedge clk) begin
        if(reset)
            q<=0;
        else if(enable) begin
            if(q < 9)
            	q<=q+1'b1;
            else
                q<=0;
        end
    end   
endmodule        

module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    
    wire [3:0] q0,q1,q2,q3;
    
    assign ena[1] = (q0 == 4'd9);
    assign ena[2] = (q0 == 4'd9)&&(q1==4'd9);
    assign ena[3] = (q0 == 4'd9)&&(q1==4'd9)&&(q2==4'd9);
    bcd c1(clk,reset,1'b1,q0);
    bcd c2(clk,reset,ena[1],q1);
    bcd c3(clk,reset,ena[2],q2);
    bcd c4(clk,reset,ena[3],q3);
    
    assign q = {q3,q2,q1,q0};
    
    

endmodule

