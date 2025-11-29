_**Atari Breakout — x86 NASM Edition**_

A complete recreation of Atari Breakout written entirely in 8086 NASM assembly, running as a 16-bit DOS .com executable.
Features smooth paddle movement, accurate ball physics, layered brick durability, PC-speaker sound effects, and fully text-mode graphics.

_**Gameplay Demo**_

https://github.com/user-attachments/assets/0192aea9-27df-48da-b9cb-6bfba1c0de7f

_**Key Features**_

_Pure x86 NASM Assembly_
- Hand-written real-mode assembly
- no external libraries
- Runs directly in DOSBox

_**Real Ball Physics**_
- Wall bounce
- paddle bounce
- brick collision detection
- Angle-changing movement

 _**Brick Durability System**_
- Top row → 2 hits
- All other rows → 1 hit

_**PC-Speaker Sound Effects**_
_Distinct tones for:_
- Brick hit
- Paddle hit
- Wall bounce
- Ball lost
- Win sound

 _**Retro Text-Mode Graphics**_
- Fast ASCII rendering
- Smooth paddle animation

 _**DOSBox Optimized**_
- Stable timing
- Responsive input

 _**Dependencies**_
- DOSBox
- NASM assembler

 _**Building From Source**_
Clone the repository:

      git clone --depth 1 https://github.com/Flodur871/Atari-Breakout
Start DOSBox and mount your directory:

    mount c c:/
    cd c:/Atari-Breakout/src
Compile using NASM:

    nasm p.asm -f bin -o break.com
That's it — no TASM, no TLINK required.

_**Playing the Game**_
From inside DOSBox, run:
 
     test.com

_**## Controls**_

| Command                       | Keybind        |
|-------------------------------|----------------|
| Move Right                    | → (Right Arrow) |
| Move Left                     | ← (Left Arrow)  |
| Restart / Change Brick Colors | Space          |
| Pause / Quit                  | Escape         |

_**How to Play**_
- The ball launches automatically
- Hit bricks to destroy them
- Missing the ball three times ends the game
- Clear all bricks to win
- Press Space to restart anytime

 _**About the Project**_
_This project demonstrates:_
- BIOS keyboard input
- PC-speaker tones
- VGA text-mode rendering
- Physics in pure assembly
- Efficient low-level game logic

 _**License**_
MIT License
