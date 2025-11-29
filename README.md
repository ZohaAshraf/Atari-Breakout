                                                   **# Atari-Breakout**
Atari Breakout recreated entirely in x86 NASM assembly and compiled as a DOS .com executable. The game runs smoothly inside DOSBox with full paddle movement, brick collision detection, layered brick durability, and PC-speaker sound effects for hits, wall bounces, life loss, and victory. This project demonstrates low-level game logic, input handling, real-time ball physics, and text-mode rendering in assembly. Includes full source code, build instructions, screenshots, and a gameplay demo video.

                                                  **🎮 Key Features:**

Pure x86 NASM assembly
Entire game written from scratch using real-mode assembly.

                                                **DOS .com executable:**
1) Lightweight, fast, and runs on DOSBox or real MS-DOS.
2) Smooth paddle movement
3) Uses keyboard interrupt reading for responsive controls.

                                               **Real ball physics:**
1) Ball bounces off bricks, walls, and the paddle with directional changes.

                                               **Brick durability system:**
1) Top row bricks require 2 hits
2) Remaining rows require 1 hit


                                              **PC-Speaker sound effects:**
Distinct tones for:
Brick destroyed
Wall bounce
Paddle hit
Ball lost
Game won

                                             **Retro text-mode graphics:**
Draws paddle, ball, and bricks using simple ASCII-style characters.

                                             **Optimized for DOSBox:**
Fast gameplay loop, clean timing, and accurate key handling.

                                             **Well-structured source:**
Functions for drawing, sound, input, physics, and collision.

                                                  **🕹️ How to Play**
Controls
Left Arrow **→** Move paddle left
Right Arrow **→** Move paddle right
ESC **→** Quit the game

                                                  **Objective:**
Break all the bricks without letting the ball fall below your paddle.   

                                              **How Gameplay Works:**
The ball launches automatically and begins moving across the screen.
Hit the bricks with the ball to destroy them.
If you miss the ball and it goes below the paddle, the game ends.
When all bricks are removed, you win and a victory sound is played.

                                               **GamePlay Demo:**                      
https://github.com/user-attachments/assets/0192aea9-27df-48da-b9cb-6bfba1c0de7f


