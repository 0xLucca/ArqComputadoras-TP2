`timescale 1ns / 1ps

module tb_rx;
    parameter NB_DATA = 8;
    
    reg clk;
    reg reset;
    reg tb_tick;
    reg rx_data;
    wire [NB_DATA-1:0]data;
    wire valid;
    
    initial
    begin
        #0
        clk = 0;
        reset = 1;
        rx_data = 1;

        #20
        reset = 0;
        
        #50
        rx_data = 0;     
        
        
        #1000
        $finish;  
    end    
    
    always #0.5 clk = ~clk;
    rx
    #(
        .NB_DATA( NB_DATA )        
    )
    u_rx
    (
        .i_clk(clk),
        .i_reset(reset),
        .i_tick(tb_tick),
        .i_rx_data(rx_data),                
        .o_data(data),
        .o_valid(valid)        
    );
endmodule