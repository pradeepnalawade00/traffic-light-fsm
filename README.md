# 🚦 Traffic Light Finite State Machine (FSM) — Verilog HDL

<div align="center">

![Verilog](https://img.shields.io/badge/Verilog-HDL-FF6B35?style=for-the-badge)
![FPGA](https://img.shields.io/badge/FPGA-Simulation-6C3483?style=for-the-badge)
![ModelSim](https://img.shields.io/badge/ModelSim-Verified-27AE60?style=for-the-badge)
![Digital Design](https://img.shields.io/badge/Digital-Design-2E86C1?style=for-the-badge)

*A fully synthesizable, FPGA-ready traffic light controller implemented in Verilog HDL using Moore FSM architecture.*

</div>

---

## 📌 Project Overview

This project implements a **4-state Moore Finite State Machine (FSM)** for a standard 4-way traffic light intersection. The design is written in **Verilog HDL**, simulated using **ModelSim**, and is fully synthesizable for deployment on FPGA hardware (Xilinx/Intel families).

The controller manages the **RED**, **YELLOW**, and **GREEN** signal outputs across a timed sequence — mimicking real-world traffic signal timing logic.

---

## 🔷 FSM State Diagram

```
         ┌──────────────────────────────────────────┐
         │                                          │
         ▼                                          │
    ┌─────────┐   timer_done    ┌─────────┐         │
    │  S0     │ ──────────────► │  S1     │         │
    │  GREEN  │                 │  YELLOW │         │
    │  G=1    │                 │  Y=1    │         │
    └─────────┘                 └─────────┘         │
         ▲                           │ timer_done   │
         │                           ▼              │
    ┌─────────┐   timer_done    ┌─────────┐         │
    │  S3     │ ◄────────────── │  S2     │         │
    │  YELLOW │                 │  RED    │         │
    │  Y=1    │                 │  R=1    │         │
    └─────────┘                 └─────────┘         │
         │                                          │
         └──────────────────────────────────────────┘
```

| State | Name      | Outputs (R, Y, G) | Duration |
|-------|-----------|-------------------|----------|
| S0    | GREEN     | 0, 0, 1           | 30 cycles |
| S1    | YELLOW    | 0, 1, 0           | 5 cycles  |
| S2    | RED       | 1, 0, 0           | 30 cycles |
| S3    | YELLOW    | 0, 1, 0           | 5 cycles  |

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| **Verilog HDL** | RTL design and state machine implementation |
| **ModelSim** | Functional simulation and waveform analysis |
| **Xilinx Vivado / ISE** | Synthesis and FPGA implementation |
| **Testbench (Verilog)** | Automated stimulus and output verification |

---

## 📁 Repository Structure

```
traffic-light-fsm/
│
├── src/
│   ├── traffic_light_fsm.v      # Main FSM module
│   └── timer_module.v           # Countdown timer submodule
│
├── testbench/
│   └── tb_traffic_light.v       # Simulation testbench
│
├── simulation/
│   └── waveform_screenshot.png  # ModelSim output waveform
│
└── README.md
```

---

## ⚙️ How to Simulate

### ModelSim
```bash
# Compile the design
vlog src/traffic_light_fsm.v src/timer_module.v testbench/tb_traffic_light.v

# Run simulation
vsim tb_traffic_light

# In ModelSim TCL console:
run -all
```

### Xilinx Vivado (Synthesis)
1. Create a new RTL project in Vivado
2. Add `src/*.v` as design sources
3. Add `testbench/tb_traffic_light.v` as simulation source
4. Run Behavioral Simulation → Synthesis → Implementation

---

## 📊 Key Design Decisions

- **Moore FSM** chosen over Mealy for **glitch-free outputs** — outputs depend only on current state, not inputs
- **Parameterized timer durations** — easy to reconfigure signal timing without modifying state logic
- **Synchronous reset** — ensures predictable FPGA startup behavior
- **One-hot encoding** considered for FPGA speed; binary encoding used for resource efficiency

---

## 🎯 Learning Outcomes

- VLSI digital design methodology (RTL → Synthesis → Implementation)
- FSM design patterns (Moore vs. Mealy trade-offs)
- Verilog HDL syntax for sequential and combinational logic
- Writing self-checking testbenches for automated verification

---

## 👤 Author

**Pradeep Nalawade** | ECE Student | VLSI & Embedded Systems Enthusiast

[![Portfolio](https://img.shields.io/badge/Portfolio-Visit-A78BFA?style=flat-square)](https://pradeepnalawade00.github.io/)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=flat-square&logo=linkedin)](https://www.linkedin.com/in/pradeep-nalawade-950244314/)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=flat-square&logo=github)](https://github.com/pradeepnalawade00)
