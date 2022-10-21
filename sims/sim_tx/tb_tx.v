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
        
        #20000
        valid = 1;
        
        #9780
        data[0] = 1; //bit 1
        
        #9780
        data[1] = 1; //bit 2
        
        #9780
        data[2] = 1; //bit 3
        
        #9780
        data[3] = 1; //bit 4
        
        #9780
        data[4] = 0; //bit 5
        
        #9780
        data[5] = 0; //bit 6
        
        #9780
        data[6] = 1; //bit 7
        
        #9780
        data[7] = 0; //bit 8
        
        #9780
        data[8] = 1; //bit 9
        
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