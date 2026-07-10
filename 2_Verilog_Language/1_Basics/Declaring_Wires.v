`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
    
    wire and1,and2,or1;
    
    and(and1,a,b);
    and(and2,c,d);
    
    or(or1,and1,and2);
    
    assign out = or1;
    assign out_n = ~or1;

endmodule

