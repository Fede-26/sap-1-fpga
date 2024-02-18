[![](https://github.com/Fede-26/sap-1-fpga/workflows/VUnit%20Tests/badge.svg)](https://github.com/Fede-26/sap-1-fpga/actions)


# SAP-1 implementation in VHDL

This is a VHDL implementation of the Simple As Possible (SAP-1) computer. The SAP-1 is a simple 8-bit computer with a 16-byte memory, designed by Albert Paul Malvino and Jerald A. Brown.

## What is implemented

- [x] 8-bit ALU
- [x] 8-bit Registers (A, B)
- [x] 4-bit RAM

## Hardware

This repo uses the Sipeed Tang Nano 9k board and the Gowin EDA.

It uses VUnit for testing and GHDL for simulation.

## Getting Started

Open the project in Gowin EDA and run the synthesis. The project is already set up to use the Tang Nano 9k board.

## Pinout

For now I didn't actually flashed the board, so no layout is available.