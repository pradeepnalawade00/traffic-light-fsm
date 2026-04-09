`timescale 1ns / 1ps

module traffic_light_tb;

// Inputs
reg clk;
reg rst;

// Outputs
wire red;
wire green;
wire yellow;

// Instantiate the Unit Under Test (UUT)
traffic_light uut (
    .clk    (clk),
    .rst    (rst),
    .red    (red),
    .green  (green),
    .yellow (yellow)
);

// Clock generation: 10ns period
initial clk = 0;
always #5 clk = ~clk;

// Self-checking task
task check;
    input exp_red, exp_green, exp_yellow;
    input [63:0] sim_time;
    begin
        if (red !== exp_red || green !== exp_green || yellow !== exp_yellow) begin
            $display("FAIL at time %0t: red=%b green=%b yellow=%b (expected %b %b %b)",
                      sim_time, red, green, yellow, exp_red, exp_green, exp_yellow);
        end else begin
            $display("PASS at time %0t: red=%b green=%b yellow=%b",
                      sim_time, red, green, yellow);
        end
    end
endtask

integer i;

initial begin
    // Apply reset
    rst = 1;
    repeat(2) @(posedge clk);
    rst = 0;

    // --- RED phase: 5 cycles ---
    $display("--- RED phase ---");
    for (i = 0; i < 5; i = i + 1) begin
        @(posedge clk); #1;
        check(1, 0, 0, $time);
    end

    // --- GREEN phase: 4 cycles ---
    $display("--- GREEN phase ---");
    for (i = 0; i < 4; i = i + 1) begin
        @(posedge clk); #1;
        check(0, 1, 0, $time);
    end

    // --- YELLOW phase: 2 cycles ---
    $display("--- YELLOW phase ---");
    for (i = 0; i < 2; i = i + 1) begin
        @(posedge clk); #1;
        check(0, 0, 1, $time);
    end

    // --- Second RED phase (confirms loop) ---
    $display("--- Back to RED (loop confirmed) ---");
    @(posedge clk); #1;
    check(1, 0, 0, $time);

    $display("=== Simulation complete ===");
    $finish;
end

// Dump waveforms
initial begin
    $dumpfile("traffic_light_tb.vcd");
    $dumpvars(0, traffic_light_tb);
end

endmodule