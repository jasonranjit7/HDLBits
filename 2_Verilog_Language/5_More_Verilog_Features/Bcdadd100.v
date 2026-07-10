module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );

    wire [399:0] c;
    
    bcd_fadd add(.a(a[3:0]),
                 .b(b[3:0]),
                 .cin(cin),
                 .cout(c[3:0]),
                 .sum(sum[3:0])
                );    
    genvar i;
    generate
        for(i=4;i<400;i=i+4)
            begin :bcd_loop
                bcd_fadd add(.a(a[i+3:i]),
                             .b(b[i+3:i]),
                             .cin(c[i-1:i-4]),
                             .cout(c[i+3:i]),
                             .sum(sum[i+3:i])
                       );
                end
    endgenerate
    
    assign cout = c[396];   
    
    
endmodule

