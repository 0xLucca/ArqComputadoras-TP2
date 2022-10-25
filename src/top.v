`timescale 1ns / 1ps

module top
#(
    parameter NB_DATA = 8,
    parameter NB_OPS = 6
)
(
    input i_clk,
    input i_reset,
    input i_rx_data,
    output o_tx_serial_data,
    output [NB_DATA-1:0] o_alu
);
    
    wire tick;
    wire [NB_DATA-1:0] rx_data;
    wire rx_valid;
    wire [NB_DATA-1:0] tx_data;
    wire tx_serial_data;
    wire tx_valid;
    wire [NB_DATA-1:0] data_a;
    wire [NB_DATA-1:0] data_b;
    wire [NB_OPS-1:0] ops;
    wire [NB_DATA-1:0] res;
    
    baud_rate_generator
    #(
        100000000,
        9600
    )
    u_baud_rate_generator
    (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .o_tick(tick)
    );
    
    rx
    #(
        NB_DATA
    )
    u_rx
    (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_tick(tick),
        .i_rx_data(i_rx_data),
        .o_data(rx_data),
        .o_valid(rx_valid)
    );
    
    tx
    #(
        NB_DATA
    )
    u_tx
    (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_tick(tick),
        .i_valid(tx_valid),
        .i_data(tx_data),
        .o_tx_data(tx_serial_data)
    );

    interface_alu
    #(
        NB_DATA,
        NB_OPS
    )
    u_interface_alu
    (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_rx_data(rx_data),
        .i_rx_valid(rx_valid),
        .i_res(res),
        .o_data_a(data_a),
        .o_data_b(data_b),
        .o_ops(ops),
        .o_tx_data(tx_data),
        .o_tx_valid(tx_valid)
    );
    
    alu 
    #(
        NB_DATA,
        NB_OPS
    )
    u_alu
    (
        .i_data_a(data_a),
        .i_data_b(data_b),
        .i_ops(ops),
        .o_res(res)
    );
    
    assign  o_tx_serial_data = tx_serial_data;
    assign o_alu = res;
    
endmodule
