// ============================================================
//  Testbench for Traffic Light Controller FSM
//  Simulates clock + reset, runs for 2 full cycles,
//  and dumps waveform to traffic_light.vcd for GTKWave.
// ============================================================

`timescale 1ns / 1ps   // 1 time unit = 1ns, precision = 1ps

module traffic_light_tb;

    // ---- Declare signals ----
    reg  clk;
    reg  rst;
    wire red, yellow, green;

    // ---- Instantiate the design under test (DUT) ----
    traffic_light dut (
        .clk    (clk),
        .rst    (rst),
        .red    (red),
        .yellow (yellow),
        .green  (green)
    );

    // ---- Clock generation: toggles every 5ns → 10ns period = 100MHz ----
    initial clk = 0;
    always #5 clk = ~clk;

    // ---- Waveform dump for GTKWave ----
    initial begin
        $dumpfile("traffic_light.vcd");
        $dumpvars(0, traffic_light_tb);
    end

    // ---- Stimulus ----
    initial begin
        // Apply reset for 2 clock cycles
        rst = 1;
        @(posedge clk); #1;
        @(posedge clk); #1;
        rst = 0;

        // Run for 3 full RED-GREEN-YELLOW cycles
        // Total cycles per loop = RED_TIME + GREEN_TIME + YELLOW_TIME = 6+4+2 = 12
        // 3 loops = 36 cycles
        repeat (36) @(posedge clk);

        $display("Simulation complete.");
        $finish;
    end

    // ---- Monitor: print state changes to terminal ----
    initial begin
        $display("Time\t\tRED\tYELLOW\tGREEN");
        $monitor("%0t ns\t\t%b\t%b\t%b", $time, red, yellow, green);
    end

endmodule
