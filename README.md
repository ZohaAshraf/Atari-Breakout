# Atari Breakout — x86 NASM Edition

A complete recreation of Atari Breakout written entirely in 8086 NASM assembly, running as a 16-bit DOS .com executable.
Features smooth paddle movement, accurate ball physics, layered brick durability, PC-speaker sound effects, and fully text-mode graphics.

## Gameplay Demo

https://github.com/user-attachments/assets/0192aea9-27df-48da-b9cb-6bfba1c0de7f

## Key Features

### Pure x86 NASM Assembly
- hand-written real-mode assembly
- no external libraries
- runs in DOSBox
- pure .COM format (ORG 0100h)

### Menu & UI System
- main menu (Play / Instructions / Exit)
- instructions page
- clean ASCII borders and text rendering

### Real Ball Physics
- Wall bounce
- paddle bounce with angle zones
- brick collision detection
- variable direction changes
- frame-based movement timing

 ### Brick Durability System
- Top row → 2 hits
- All other rows → 1 hit

### PC-Speaker Sound Effects
#### Distinct tones for:
- Brick hit
- Paddle hit
- Wall bounce
- life lost
- Win sound

 ### Retro Text-Mode Graphics
- fast memory-mapped VGA text rendering
- smooth paddle animation
- border and layout system

 ### DOSBox Optimized
- Stable timing
- Responsive input

 ### Dependencies
- DOSBox
- NASM assembler

 ### Building From Source
 
Clone the repository:

      git clone --depth 1 https://github.com/Flodur871/Atari-Breakout
Start DOSBox and mount your directory:

    mount c c:/
    cd c:/Atari-Breakout/src
Compile using NASM:

    nasm p.asm -f bin -o break.com
That's it — no TASM, no TLINK required.

### Playing the Game

From inside DOSBox, run:
 
     test.com

## Controls

| Command                       | Keybind        |
|-------------------------------|----------------|
| Move Right                    | → (Right Arrow) |
| Move Left                     | ← (Left Arrow)  |
| Pause / Quit                  | Escape         |

## How to Play
- The ball launches automatically
- Hit bricks to destroy them
- Missing the ball costs 1 life
- Game over when lives = 0
- Press Space to restart anytime

 ## About the Project
 
### This project demonstrates:
- BIOS keyboard input
- PC-speaker tones
- VGA text-mode rendering
- Physics in pure assembly
- Efficient low-level game logic

 ## License
 
MIT License
