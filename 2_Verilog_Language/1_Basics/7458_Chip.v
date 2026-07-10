module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
    
    wire and1,and2,and3,and4;
    
    and(and1,p2a,p2b);
    and(and2,p2c,p2d);
    and(and3,p1a,p1b,p1c);
    and(and4,p1d,p1e,p1f);
    
    or(p2y,and1,and2);
    or(p1y,and3,and4);
    


endmodule

