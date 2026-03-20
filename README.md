# traffic-light-fsm-verilog
Traffic Light Controller using Finite State Machine (FSM) in Verilog HDL

A hardware implementation of a 3-state Finite State Machine (FSM) 
that simulates a traffic light controller, written in Verilog HDL 
and verified using Icarus Verilog and GTKWave.

## States
| State  | Output | Duration |
|--------|--------|----------|
| RED    | red = 1 | 6 clock cycles |
| GREEN  | green = 1 | 4 clock cycles |
| YELLOW | yellow = 1 | 2 clock cycles |

## FSM Diagram
```
RST → RED (6 cycles) → GREEN (4 cycles) → YELLOW (2 cycles) → RED ...
```

## Simulation Waveform
![Waveform](waveform.png)

## Tools Used
- Verilog HDL
- Icarus Verilog (simulation)
- GTKWave (waveform viewer)

## How to Run
```bash
iverilog -o traffic_light_sim.out traffic_light_tb.v traffic_light.v
vvp traffic_light_sim.out
gtkwave traffic_light.vcd
```

## Key Concepts
- Moore FSM (outputs depend only on current state)
- Synchronous reset
- Parameterized timer durations
- Separate sequential and combinational always blocks
