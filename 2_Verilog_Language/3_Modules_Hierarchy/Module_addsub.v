module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire [31:0] b1 = b^{32{sub}};
    wire a1;
    
    add16 add1(.a(a[15:0]),
               .b(b1[15:0]),
               .cin(sub),
               .sum(sum[15:0]),
               .cout(a1)
         );
    add16 add2(.a(a[31:16]),
               .b(b1[31:16]),
               .cin(a1),
               .sum(sum[31:16]),
               .cout()
              );

endmodule

