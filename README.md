Single Stage Pipeline Register (Valid/Ready Handshake)
Project Overview

This project implements and verifies a Single Stage Pipeline Register using SystemVerilog. The design uses an industry-standard valid/ready handshake protocol to ensure safe and efficient data transfer between hardware modules.

The pipeline stage acts as a buffering element between upstream and downstream modules while supporting backpressure, ensuring reliable streaming data transfer without data loss or duplication.

Project Objectives
Design a fully synthesizable pipeline register
Implement standard valid/ready handshake protocol
Support backpressure handling
Ensure clean reset initialization
Verify functionality using a self-checking testbench
Validate design using simulation waveform results

Design Description
The pipeline register stores one data word and transfers it based on handshake signals between input and output interfaces.

Input Interface
Signal	Description
clk	System clock
rst_n	Active-low reset
in_valid	Indicates valid input data
in_ready	Indicates pipeline can accept data
in_data	Input data bus


Output Interface

Signal	Description
out_valid	Indicates valid output data
out_ready	Indicates downstream readiness
out_data	Output data bus

Handshake Mechanism

Input Data Transfer
Data is accepted when:
in_valid && in_ready

Output Data Transfer
Data is transmitted when:
out_valid && out_ready

Design Features

Fully synthesizable RTL design
Parameterized data width
Single-cycle throughput capability
Backpressure support
Clean reset state initialization
No data loss or duplication

Industry-standard streaming interface implementation

Testbench Description

The project includes a self-checking SystemVerilog testbench that verifies the pipeline register functionality.

Verification Techniques Used
Randomized stimulus generation
Directed test scenarios
Scoreboard-based data integrity checking
Reset verification
Backpressure scenario testing

The testbench continuously compares input and output data to ensure correct pipeline behavior.

Simulation Results Summary

The simulation waveform confirms correct functional operation of the pipeline register.

Signal Behaviour
Clock and Reset
clk drives sequential pipeline operations.
rst_n initializes the pipeline into a clean empty state.

Input Signals
in_valid indicates availability of input data.
in_ready controls when pipeline accepts data.
in_data is stored only during valid handshake.

Output Signals
out_valid indicates stored data availability.
out_ready controls downstream acceptance.
out_data correctly matches previously accepted input data.

Functional Observations
Data is transferred only during valid handshake.
Backpressure is handled correctly when downstream blocks data.
No data loss or duplication is observed.
Pipeline resets safely and resumes operation correctly.
Data ordering and integrity are maintained.
