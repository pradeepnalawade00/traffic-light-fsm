module traffic_light (
    input  wire clk,
    input  wire rst,
    output reg  red,
    output reg  green,
    output reg  yellow
);

// State encoding
parameter RED_STATE    = 2'b00;
parameter GREEN_STATE  = 2'b01;
parameter YELLOW_STATE = 2'b10;

// Registers
reg [1:0] state;
reg [2:0] counter;

// State transition (sequential)
always @(posedge clk or posedge rst) begin
    if (rst) begin
        state   <= RED_STATE;
        counter <= 3'd0;
    end else begin
        case (state)
            RED_STATE: begin
                if (counter == 3'd4) begin   // 5 cycles (0 to 4)
                    state   <= GREEN_STATE;
                    counter <= 3'd0;
                end else
                    counter <= counter + 1;
            end
            GREEN_STATE: begin
                if (counter == 3'd3) begin   // 4 cycles (0 to 3)
                    state   <= YELLOW_STATE;
                    counter <= 3'd0;
                end else
                    counter <= counter + 1;
            end
            YELLOW_STATE: begin
                if (counter == 3'd1) begin   // 2 cycles (0 to 1)
                    state   <= RED_STATE;
                    counter <= 3'd0;
                end else
                    counter <= counter + 1;
            end
            default: begin
                state   <= RED_STATE;
                counter <= 3'd0;
            end
        endcase
    end
end

// Output logic (combinational)
always @(*) begin
    red    = 0;
    green  = 0;
    yellow = 0;
    case (state)
        RED_STATE:    red    = 1;
        GREEN_STATE:  green  = 1;
        YELLOW_STATE: yellow = 1;
    endcase
end

endmodule