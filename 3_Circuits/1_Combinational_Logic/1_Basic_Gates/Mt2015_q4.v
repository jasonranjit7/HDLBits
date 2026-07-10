module A (input x, input y, output z);
    assign z = (x^y)&x;
endmodule

module B(input x, input y, output z);
    xnor(z,x,y);
endmodule

module top_module (input x, input y, output z);
    
    wire A1,A2,B1,B2,or1,and1;
    
    A a1(.x(x),
         .y(y),
         .z(A1)
        );
    
    A a2(.x(x),
         .y(y),
         .z(A2)
        );
    
    B b1(.x(x),
         .y(y),
         .z(B1)
        );
    
    B b2(.x(x),
         .y(y),
         .z(B2)
        );
    
    or(or1,A1,B1);
    and(and1,A2,B2);
    
    xor(z,or1,and1);
    
    
endmodule

