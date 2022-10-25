`timescale 1ns / 1ps

module tb_interface_alu;
    parameter NB_DATA = 8;
    parameter NB_OPS = 6;
    
    reg clk;
    reg reset;
    reg [NB_DATA-1:0] rx_data;
    reg rx_valid;
    reg [NB_DATA-1:0] res;
    wire[NB_DATA-1:0] data_a;
    wire[NB_DATA-1:0] data_b;
    wire[NB_OPS-1:0] ops;
    wire [NB_DATA-1:0] tx_data;
    wire tx_valid;
    
    initial
    begin
        #0
        clk = 0;
        reset = 1;
        rx_data = 0;
        rx_valid = 0;
        
        #10
        reset= 0;
        
        //Cargo 0x0F en data_b
        #10
        rx_data = 1;
        rx_valid = 1;
        
        #1
        rx_valid = 0;
        
        #10
        rx_data = 8'h0F;
        rx_valid = 1;
        
        #1
        rx_valid = 0;
        
        //Cargo 0xFF en data_a
        #10
        rx_data = 0;
        rx_valid = 1;
        
        #1
        rx_valid = 0;
        
        #10
        rx_data = 8'hFF;
        rx_valid = 1;
        
        #1
        rx_valid = 0;
        
        //Transmito el valor de salida de la ALU. Deberia ser 0xF0
        #10
        rx_data = 8'hFF;
        rx_valid = 1;
        
        #1
        rx_valid = 0;
        
        #10
        
        $finish;
    end
    
    always #0.5 clk = ~clk;
    
    interface_alu
    #()
    u_interface_alu
    (
    .i_clk(clk),
    .i_reset(reset),
    .i_rx_data(rx_data),
    .i_rx_valid(rx_valid),
    .i_res(res),
    .o_data_a(data_a),
    .o_data_b(data_b),
    .o_ops(ops),
    .o_tx_data(tx_data),
    .o_tx_valid(tx_valid)
    );
endmodule