`timescale 1ns / 1ps

module alu
    #(
        parameter NB_DATA = 8,
        parameter NB_OPS = 6
    )
    (
        input signed [NB_DATA-1 : 0] i_data_a,
        input signed [NB_DATA-1 : 0] i_data_b,
        input [NB_OPS-1 : 0] i_ops,
        output signed [NB_DATA : 0] o_res
    );
    
    reg [NB_DATA-1 : 0] data_a_un;
    reg [NB_DATA-1 : 0] data_b_un;
    reg signed [NB_DATA-1 : 0] res;
    reg carry;
   
    always @(*)
    begin
        case(i_ops)
            6'b100000://0x20
                {carry,res} = data_a_un + data_b_un;
            6'b100010://0x22
                {carry,res} = {1'b0 , i_data_a - i_data_b};
            6'b100100://0x24
                {carry,res} = {1'b0 , i_data_a & i_data_b};
            6'b100101://0x25
                {carry,res} = {1'b0 , i_data_a | i_data_b};
            6'b100110://0x26
                {carry,res} = {1'b0 , i_data_a ^ i_data_b};
            6'b000011://0x03
                {carry,res} = {1'b0 , i_data_a >>> 1};
            6'b000010://0x02
                {carry,res} = {1'b0 , i_data_a >> 1};
            6'b100111://0x27      
                {carry,res} = {1'b0 , ~(i_data_a | i_data_b)};
            default:
                {carry,res} = {1'b0 , i_data_a - i_data_b};
        endcase
    end
    
    always @(*)
    begin
        data_a_un = i_data_a;
        data_b_un = i_data_b;        
    end
    

    assign o_res = {carry,res};
endmodule