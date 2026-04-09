# Traffic Light Controller — FSM in Verilog

Finite State Machine (FSM) implementing a 3-phase traffic light controller.
Designed and simulated using **Xilinx Vivado**.

## States
| State  | RED | GREEN | YELLOW | Duration |
|--------|-----|-------|--------|----------|
| RED    |  1  |   0   |   0    | 5 clocks |
| GREEN  |  0  |   1   |   0    | 4 clocks |
| YELLOW |  0  |   0   |   1    | 2 clocks |

## Tools
- Verilog HDL
- Xilinx Vivado (Behavioral Simulation)
- Self-checking testbench with PASS/FAIL output

