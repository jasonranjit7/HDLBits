module top_module (
    input in1,
    input in2,
    input in3,
    output out);
    
    wire x1;
    
    xnor(x1,in1,in2);
    xor(out,x1,in3);

endmodule

