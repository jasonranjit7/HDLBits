module top_module(
    input clk,
    input areset,

    input  predict_valid,
    input  [6:0] predict_pc,
    output predict_taken,
    output reg [6:0] predict_history, // FIX 2: Added 'reg'

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
    reg[1:0] pht [127:0];
    integer i;
    
    wire [6:0] train_index = train_pc ^ train_history;
    wire [6:0] predict_index = predict_pc ^ predict_history;
    
    always@(posedge clk or posedge areset) begin
        if(areset) begin
            for(i=0; i<128; i=i+1)
                pht[i] <= 2'b01;
        end
        else begin
            if(train_valid) begin
                if(train_taken) begin
                    if(pht[train_index] != 2'b11)
                        pht[train_index] <= pht[train_index] + 1'b1;
                end
                else begin
                    if(pht[train_index] != 2'b00)
                        pht[train_index] <= pht[train_index] - 1'b1;
                end
            end
        end
    end
    
    assign predict_taken = pht[predict_index][1];
    
    always@(posedge clk or posedge areset) begin
        if(areset)
            predict_history <= 7'b0;
        else begin
            if(train_valid && train_mispredicted)
                predict_history <= {train_history[5:0], train_taken};
            else if(predict_valid)
                predict_history <= {predict_history[5:0], predict_taken};
        end
    end

endmodule
