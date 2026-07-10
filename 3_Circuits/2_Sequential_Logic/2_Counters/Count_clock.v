module bcd(input clk,
                input reset,
                input enable,
                output [7:0] q);
    
    always@(posedge clk) begin
        if(reset)
            q<=0;
        else if(enable) begin
            if(q[3:0]<9)
                q[3:0]<=q[3:0]+1'b1;
            else if(q[3:0]==9 && q[7:4]<5) begin
                q[7:4]<=q[7:4]+1'b1;
                q[3:0]<=0;
            end
            else if(q == 8'h59)
                q<=0;
        end
    end
endmodule

module bcd_h(input clk,
             input reset,
             input enable,
             output [7:0] q,
             output pm);
    
    always@(posedge clk) begin
        if(reset)
            q<=8'h12;
        else if(enable) begin
            if(q == 8'h12) begin
                q<=8'h01;
            end
            else if(q == 8'h11) begin
                pm<=~pm;
                q<=8'h12;
            end
            else if(q[3:0]<9)
                q[3:0]<=q[3:0]+1'b1;
            else if(q[3:0]==9 && q[7:4]<1) begin
                q[7:4]<=q[7:4]+1'b1;
                q[3:0]<=0;
            end
        end
    end
endmodule

module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss);
    
    wire ena_m,ena_h,ena_h2;
    assign ena_m = (ss == 8'h59);
    assign ena_h = (ss == 8'h59) &&(mm == 8'h59);
    
    bcd counts(clk,reset,ena,ss);
    bcd countm(clk,reset,ena_m,mm);
    bcd_h counth(clk,reset,ena_h,hh,pm);
    
    
    

endmodule

