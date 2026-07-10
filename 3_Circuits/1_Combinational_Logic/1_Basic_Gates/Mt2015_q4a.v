module top_module (input x, input y, output z);
    
    wire x1;
    
    xor(x1,x,y);
    and(z,x1,x);

endmodule

