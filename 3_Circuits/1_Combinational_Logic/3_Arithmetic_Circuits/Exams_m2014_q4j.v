module FA(input x,y,cin,
          output sum,cout);
    assign sum = x^y^cin;
    assign cout = x&y|y&cin|cin&x;
endmodule

module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    
    wire [3:0] cout;
    
    FA a0(.x(x[0]),
          .y(y[0]),
          .cin(),
          .sum(sum[0]),
          .cout(cout[0])
         );
    FA a1(.x(x[1]),
          .y(y[1]),
          .cin(cout[0]),
          .sum(sum[1]),
          .cout(cout[1])
         );
    FA a2(.x(x[2]),
          .y(y[2]),
          .cin(cout[1]),
          .sum(sum[2]),
          .cout(cout[2])
         );
    FA a3(.x(x[3]),
          .y(y[3]),
          .cin(cout[2]),
          .sum(sum[3]),
          .cout(sum[4])
         );

endmodule

