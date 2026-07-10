module top_module (
    input a,
    input b,
    input c,
    input d,
    output q );//

    assign q = b&d|a&d|b&c&~d|a&~b&c; // Fix me

endmodule

