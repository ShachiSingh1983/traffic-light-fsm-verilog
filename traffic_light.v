// ============================================================
//  Traffic Light Controller - Finite State Machine (FSM)
//  Tool: Icarus Verilog
//  Description: 3-state FSM controlling RED, YELLOW, GREEN
//               lights with parameterized timer durations.
// ============================================================

module traffic_light (
    input  wire clk,        // Clock signal
    input  wire rst,        // Active-high synchronous reset
    output reg  red,        // RED light output
    output reg  yellow,     // YELLOW light output
    output reg  green       // GREEN light output
);

    // ---- State encoding ----
    parameter RED_STATE    = 2'b00;
    parameter GREEN_STATE  = 2'b01;
    parameter YELLOW_STATE = 2'b10;

    // ---- Timer durations (in clock cycles) ----
    parameter RED_TIME    = 6;   // RED stays on for 6 cycles
    parameter GREEN_TIME  = 4;   // GREEN stays on for 4 cycles
    parameter YELLOW_TIME = 2;   // YELLOW stays on for 2 cycles

    // ---- Internal registers ----
    reg [1:0] current_state;
    reg [3:0] counter;       // Counts clock cycles in each state

    // ---- State register + counter (sequential logic) ----
    always @(posedge clk) begin
        if (rst) begin
            current_state <= RED_STATE;
            counter       <= 0;
        end else begin
            counter <= counter + 1;

            case (current_state)
                RED_STATE: begin
                    if (counter == RED_TIME - 1) begin
                        current_state <= GREEN_STATE;
                        counter       <= 0;
                    end
                end

                GREEN_STATE: begin
                    if (counter == GREEN_TIME - 1) begin
                        current_state <= YELLOW_STATE;
                        counter       <= 0;
                    end
                end

                YELLOW_STATE: begin
                    if (counter == YELLOW_TIME - 1) begin
                        current_state <= RED_STATE;
                        counter       <= 0;
                    end
                end

                default: begin
                    current_state <= RED_STATE;
                    counter       <= 0;
                end
            endcase
        end
    end

    // ---- Output logic (combinational) ----
    always @(*) begin
        // Default all lights OFF
        red    = 0;
        yellow = 0;
        green  = 0;

        case (current_state)
            RED_STATE:    red    = 1;
            GREEN_STATE:  green  = 1;
            YELLOW_STATE: yellow = 1;
        endcase
    end

endmodule
