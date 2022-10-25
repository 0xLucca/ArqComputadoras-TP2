`timescale 1ns / 1ps

module tb_top;
    parameter NB_DATA = 8;
    parameter NB_OPS = 6;
    
    reg clk;
    reg reset;
    reg rx_data;
    wire tx_serial_data;
    
    initial
    begin
        #0
        clk = 0;    
        reset = 1;
        rx_data = 1;
        
        #10
        reset = 0;
        
        // Data lccation
        #100000
        rx_data = 0;
        
        #9780
        rx_data = 0;
        
        #9780
        rx_data = 0;
        
        #9780
        rx_data = 0;
        
        #9780
        rx_data = 0;
        
        #9780
        rx_data = 0;
        
        #9780
        rx_data = 0;
        
        #9780
        rx_data = 0;
        
        #9780
        rx_data = 0;
        
        #9780
        rx_data = 1;
        
        // Data a value
        #18000
        rx_data = 0;
        
        #9780
        rx_data = 1;
        
        #9780
        rx_data = 1;
        
        #9780
        rx_data = 1;
        
        #9780
        rx_data = 1;
        
        #9780
        rx_data = 0;
        
        #9780
        rx_data = 0;
        
        #9780
        rx_data = 1;
        
        #9780
        rx_data = 0;
        
        #9780
        rx_data = 1;
        
        // Get data
        #18000
        rx_data = 0;
        
        #9780
        rx_data = 1;
        
        #9780
        rx_data = 1;
        
        #9780
        rx_data = 1;
        
        #9780
        rx_data = 1;
        
        #9780
        rx_data = 1;
        
        #9780
        rx_data = 1;
        
        #9780
        rx_data = 1;
        
        #9780
        rx_data = 1;
        
        #9780
        rx_data = 1;
        
        #180000
        $finish;
        
    end    
    
    always #0.5 clk = ~clk;
    
    top
    #(
        .NB_DATA( NB_DATA ),  
        .NB_OPS( NB_OPS )      
    )
    u_top
    (
        .i_clk(clk),
        .i_reset(reset),
        .i_rx_data(rx_data),
        .o_tx_serial_data(tx_serial_data)
    );
endmodule