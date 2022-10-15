`timescale 1ns / 1ps

module rx
#(
    parameter NB_DATA = 8
)
(
    input i_clk,
    input i_reset,
    input i_tick,
    input i_rx_data,
    output [NB_DATA-1:0]o_data,
    output o_valid
);

    localparam STATE_0 = 6'b000001;
    localparam STATE_1 = 6'b000010;
    localparam STATE_2 = 6'b000100;
    localparam STATE_3 = 6'b001000;
    localparam STATE_4 = 6'b010000;
    localparam STATE_5 = 6'b100000;

    reg valid;
    reg[5:0] state;
    reg[5:0] next_state;
    reg[NB_DATA-1:0] data;
    reg[3:0] tick_counter;
    reg[3:0] rx_bit_counter;

    always @(posedge i_clk) 
    begin
        if(i_reset)
            state <= STATE_0;
        else
            state <= next_state;
    end
    
    always@(negedge i_clk)
    begin
        if(i_tick)
        begin
            case(state)
                STATE_1:
                    begin
                        tick_counter <= (tick_counter + 1)%8;
                    end
                STATE_2:
                    begin
                        tick_counter <= (tick_counter + 1)%16;
                        if(tick_counter==15)
                            begin
                                rx_bit_counter <= rx_bit_counter + 1;
                                data[rx_bit_counter] <= i_rx_data;
                            end
                    end
                default:
                    begin
                        tick_counter <= 0;
                        rx_bit_counter <= 0;
                    end
            endcase
        end  
    end
        

    always @(*)
    begin
        case(state)
            STATE_0:
                if(i_rx_data)
                    next_state = STATE_0;
                else
                    next_state = STATE_1;
                    
            STATE_1:
                if(tick_counter<7)
                    next_state = STATE_1;
                else
                    if(i_rx_data == 1)
                        next_state = STATE_0;
                    else
                        next_state = STATE_2;
                        
            STATE_2:
                if(rx_bit_counter==8)
                    begin
                        if(i_rx_data==1)
                            next_state = STATE_3;
                        else
                            next_state = STATE_0;
                    end
                else
                    next_state = STATE_2;
                    
            STATE_3:
                next_state = STATE_0;
                
            default:
                next_state = STATE_0;
        endcase
    end
    
    always@(*)
    begin
        case(state)
            STATE_3:
                valid = 1;
            default:
                valid = 0;
        endcase
    end
    
    assign o_data = data;
    assign o_valid = valid;

endmodule
