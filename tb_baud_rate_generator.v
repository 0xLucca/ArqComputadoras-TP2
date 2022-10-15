`timescale 1ns / 1ps

module tb_baud_rate_generator;

    parameter CLK_FREQ = 100000000;
    parameter BAUD_RATE = 9600;

    reg clk;
    reg reset;
    wire tb_tick;

    initial 
    begin
        #0
        clk = 0;
        reset = 1;

        #20
        reset = 0;
        
        #1000
        $finish;
    end

    always #0.5 clk = ~clk;

    baud_rate_generator
    #(
        .CLK_FREQ( CLK_FREQ ),
        .BAUD_RATE( BAUD_RATE )
    )
    u_baud_rate_generator
    (
        .i_clk(clk),
        .i_reset(reset),
        .o_tick(tb_tick)
    );
endmodule
