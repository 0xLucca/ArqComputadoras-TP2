`timescale 1ns / 1ps

module top
#(
    parameter NB_DATA = 8,
    parameter NB_OPS = 6
)
(
     input [7:0] i_sw,
     input [2:0] i_but,
     input i_clk,
     output [8:0] o_res 
);

    reg signed [NB_DATA-1 : 0] data_a;
    reg signed [NB_DATA-1 : 0] data_b;
    reg [NB_OPS-1 : 0] ops;

    always @(posedge i_clk) 
    begin
        if(i_but[0])       
            data_a <= i_sw;
    end

    always @(posedge i_clk)  
    begin
        if(i_but[1])
            data_b <= i_sw;
    end

    always @(posedge i_clk)  
    begin
        if(i_but[2])
            ops <= i_sw[5:0];
    end
    
    baud_rate_generator#()(
        .o_signal(signal)
    );
    
    rx#()(
        .i_valid(signal)
    );
      
    alu 
    #(
        8,
        6
    )
    alu1
    (
        .i_data_a(data_a),
        .i_data_b(data_b),
        .i_ops(ops),
        .o_res(o_res)
    );
endmodule
