**Atari Breakout — x86 Assembly (NASM, DOS .COM)**

A complete recreation of Atari Breakout written entirely in x86 NASM assembly and compiled as a DOS .com executable.
The game runs smoothly in DOSBox with responsive paddle movement, brick collision detection, layered brick durability, and PC-speaker sound effects for all major events.

This project showcases low-level game logic, real-time physics, keyboard interrupt handling, and text-mode rendering — all implemented from scratch in real-mode assembly.
The repository includes full source code, build instructions, screenshots, and a gameplay demo.
**
🎮** Key Features**
**Pure x86 NASM Assembly**

Entire game written from scratch using real-mode assembly.

No external libraries or frameworks.

**DOS .com Executable**

Extremely lightweight and fast.

Runs on DOSBox or real MS-DOS hardware.

Smooth Paddle Movement

Responsive input using direct keyboard interrupt reads.

**Real Ball Physics**

Ball bounces off walls, bricks, and the paddle.

Direction changes based on collision angle.

Brick Durability System

Top row bricks require 2 hits.

All other rows require 1 hit.

**PC-Speaker Sound Effects**

Distinct tones for:

Brick destroyed

Wall bounce

Paddle hit

Ball lost / game over

Game victory

**Retro Text-Mode Graphics**

Paddle, ball, and bricks rendered using ASCII-style characters.

Clean visual layout inside the DOS text screen.

**Optimized for DOSBox**

Stable timing for consistent gameplay.

Accurate keystroke reading.

Efficient update loop.

**Well-Structured Source Code**

Organized into routines for:

Drawing

Input

Physics

Collision

Sound

🕹️** How to Play**
Controls

Left Arrow → Move paddle left

Right Arrow → Move paddle right

ESC → Quit the game

**Objective**

Break all the bricks without letting the ball fall below the paddle.

Gameplay Overview

The ball launches automatically at the start.

Hit bricks to destroy them and clear the board.

Missing the ball ends the game.

Destroy all bricks to win — a victory sound is played.
