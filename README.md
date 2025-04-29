# Conway
Conway NASM x86 32bits

This project implements a simplified version of John Conway's Game of Life using NASM

# Description

The Game of Life is a cellular automaton where each cell on a grid can either be alive (1) or dead (0). In each "generation," the state of the cells evolves based on simple rules depending on the number of live neighbors.

In this implementation:

- 1 represents a live cell.

- 0 represents a dead cell.

- The initial 10x10 board (grid) is defined in the .data section.

# Structure

- grid: Represents the current 5x5 grid with cell states.

- next_grid: Temporary grid to store the next generation state.

- neighbour_count: Stores the count of live neighbors for each cell.

# Rules Applied

- Survival: A live cell with 2 or 3 live neighbors survives.

- Death: A live cell with fewer than 2 or more than 3 live neighbors dies.

- Birth: A dead cell with exactly 3 live neighbors becomes a live cell.

# Requirements

- Operating System: Linux

- Assembler: NASM

- CMake

# How to Compile and Run

- Open Ubuntu Linux terminal

- Go (cd) to the folder with the "Conway" file

- enter "make" on the terminal

- enter "make run" on the temrinal

# Group 4

- Juan Andres Gonzalez Garcia C33359

- Adam Cortes B92415

- Juan Sebastian Loaiza B74200
