`timescale 1ns / 1ps

module tb_tx;
    parameter NB_DATA = 8;
    
    reg clk;
    reg reset;
    wire tb_tick;
    reg valid;
    reg [NB_DATA-1:0]data;
    wire tx_data;
    
    initial
    begin
        #0
        clk = 0;
        reset = 1;        
        valid = 0;
        data = 0;

        #20
        reset = 0;
        data = 8'hF0;       
        
        #20000
        valid = 1;
        
        #500
        valid = 0;
        
        
        $finish;  
    end    
    
    always #0.5 clk = ~clk;
    
    baud_rate_generator
    u_baud_rate_generator
    (
        .i_clk(clk),
        .i_reset(reset),
        .o_tick(tb_tick)
    );
    
    tx
    #(
        .NB_DATA( NB_DATA )        
    )
    u_tx
    (
        .i_clk(clk),
        .i_reset(reset),
        .i_tick(tb_tick),
        .i_valid(valid),
        .i_data(data),
        .o_tx_data(tx_data)                
    );
endmodule