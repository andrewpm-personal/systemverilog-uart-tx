# UART Transmitter in SystemVerilog

This project implements a UART transmitter in SystemVerilog and verifies it using Vivado behavioral simulation. It was developed as a learning project to build a stronger understanding of RTL design, finite state machines, and testbench development.

## Overview

The transmitter sends a byte serially using the standard UART frame format:

- 1 start bit
- 8 data bits, least-significant bit first
- 1 stop bit

The design also includes a baud tick generator to control bit timing and a set of testbenches used to validate the modules in simulation.

## Features

- FSM-based UART transmitter
- Baud tick generator for bit timing
- Synchronous reset handling
- `busy` and `done` status signals
- Support for back-to-back byte transmission
- Behavioral simulation testbenches in Vivado

## Project Structure

- `rtl/counter.sv` — simple counter used for early SystemVerilog practice
- `rtl/baud_tick_gen.sv` — generates one-cycle baud ticks
- `rtl/uart_tx.sv` — UART transmitter RTL
- `tb/tb_counter.sv` — testbench for the counter
- `tb/tb_baud_tick_gen.sv` — testbench for the baud tick generator
- `tb/tb_uart_tx.sv` — testbench for the UART transmitter

## How to Run

1. Open the Vivado project.
2. Add the files in `rtl/` as Design Sources.
3. Add the files in `tb/` as Simulation Sources.
4. Run **Behavioral Simulation**.
5. Inspect the waveform for `tx`, `busy`, `done`, `state`, and `bit_index`.

## Verification Performed

The design was tested with:

- counter behavior under reset
- baud tick generation timing
- single-byte UART transmission
- reset during transmission
- back-to-back byte transmission
- `start` while busy

## Notes

- The transmitter follows the standard UART format with a start bit, 8 data bits sent LSB-first, and a stop bit.
- The design was built incrementally, with each module tested in simulation before moving to the next step.
- This project is focused on learning and understanding RTL design, not just producing a final working module.
