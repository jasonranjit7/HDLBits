module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire cs;
    wire [15:0] a2,a3;
    
    add16 add1(.a(a[15:0]),
               .b(b[15:0]),
               .cin(0),
               .sum(sum[15:0]),
               .cout(cs)
              );
    add16 add2(.a(a[31:16]),
               .b(b[31:16]),
               .cin(0),
               .sum(a2),
               .cout()
              );
    add16 add3(.a(a[31:16]),
               .b(b[31:16]),
               .cin(1),
               .sum(a3),
               .cout()
              );
    
    assign sum[31:16] = cs?a3:a2;

endmodule

