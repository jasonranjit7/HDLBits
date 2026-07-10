module top_module (input a, input b, input c, output out);//
	
    wire and1;
    andgate inst1 (and1,a,b,c,1,1);
    assign out = ~and1;

endmodule

