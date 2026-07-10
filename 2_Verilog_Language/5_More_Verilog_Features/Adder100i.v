module full_adder(input a,
                  input b,
                  input cin,
                  output sum,
                  output cout);
    
    assign sum = a^b^cin;
    
    assign cout = (a&b)|(b&cin)|(cin&a);
    
endmodule

module top_module( 
    input [99:0] a, b,
    input cin,
    output reg [99:0] cout,
    output reg [99:0] sum );
    
    wire c;
    
    full_adder add(.a(a[0]),
                   .b(b[0]),
                   .cin(cin),
                   .sum(sum[0]),
                   .cout(cout[0])
                          );
    
    genvar i;
    generate
        for(i=1;i<100;i=i+1) begin :add_loop
            full_adder add(.a(a[i]),
                           .b(b[i]),
                           .cin(cout[i-1]),
                           .sum(sum[i]),
                           .cout(cout[i])
                          );
        end
    endgenerate

endmodule



