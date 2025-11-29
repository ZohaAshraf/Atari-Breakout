; Atari Breakout Game - NASM Compatible for DOS
; Compile: nasm -f bin breakout.asm -o breakout.com
; Run in DOSBox: breakout.com

org 0x100  ; DOS .COM program format

start:
    ; Hide cursor
    mov ah, 0x01
    mov ch, 0x20
    mov cl, 0x00
    int 0x10
    
    mov byte [currentScreen], 0

mainLoop:
    cmp byte [currentScreen], 0
    je showMenu
    cmp byte [currentScreen], 1
    je showInst
    cmp byte [currentScreen], 2
    je startGame

showMenu:
    call drawMainMenu
    mov ah, 0x00
    int 0x16
    cmp al, '1'
    je selectGame
    cmp al, '2'
    je selectInst
    cmp al, '3'
    je exitProgram
    jmp mainLoop

selectGame:
    mov byte [currentScreen], 2
    jmp mainLoop

selectInst:
    mov byte [currentScreen], 1
    jmp mainLoop

showInst:
    call drawInstructions
waitInstKey:
    mov ah, 0x00
    int 0x16
    cmp ah, 0x01
    je backToMenu
    jmp waitInstKey

backToMenu:
    mov byte [currentScreen], 0
    jmp mainLoop

startGame:
    call playGame
    mov byte [currentScreen], 0
    jmp mainLoop

exitProgram:
    mov ax, 0x4C00
    int 0x21

; ===== SUBROUTINES =====

clearScreen:
    mov ax, 0xB800
    mov es, ax
    mov di, 0
    mov cx, 2000
    mov ax, 0x0020
clearLoop:
    stosw
    loop clearLoop
    ret

clearScreenBlack:
    mov ax, 0xB800
    mov es, ax
    mov di, 0
    mov cx, 2000
    mov ax, 0x0020
clearLoopBlack:
    stosw
    loop clearLoopBlack
    ret

clearScreenBlue:
    mov ax, 0xB800
    mov es, ax
    mov di, 0
    mov cx, 2000
    mov ax, 0x0020
clearLoopBlue:
    stosw
    loop clearLoopBlue
    ret

printString:
    push bx
    mov bl, ah
    mov ax, 0xB800
    mov es, ax
printLoop:
    lodsb
    cmp al, 0
    je endPrint
    mov ah, bl
    stosw
    jmp printLoop
endPrint:
    pop bx
    ret

drawMainMenu:
    call clearScreenBlack
    
    ; Minimalist border - Single line, dark gray
    mov ax, 0xB800
    mov es, ax
    
    ; Top border - single line, dark gray
    mov di, 320
    mov cx, 80
    mov ax, 0x08C4
topMenuBorder:
    stosw
    loop topMenuBorder
    
    ; Bottom border - single line, dark gray
    mov di, 3680
    mov cx, 80
    mov ax, 0x08C4
bottomMenuBorder:
    stosw
    loop bottomMenuBorder
    
    ; Side borders - minimal
    mov cx, 21
    mov di, 480
sideBordersMenu:
    mov word [es:di], 0x08B3
    mov word [es:di+158], 0x08B3
    add di, 160
    loop sideBordersMenu
    
    ; Corner pieces
    mov word [es:320], 0x08DA
    mov word [es:478], 0x08BF
    mov word [es:3680], 0x08C0
    mov word [es:3838], 0x08D9
    
    ; ATARI title - Clean white text, no background
    mov ah, 0x0F  ; White on black
    mov si, titleLine1
    mov di, 804
    call printString
    
    mov ah, 0x0F
    mov si, titleLine2
    mov di, 964
    call printString
    
    mov ah, 0x0F
    mov si, titleLine3
    mov di, 1124
    call printString
    
    ; BREAKOUT title - Cyan text, no background
    mov ah, 0x0B  ; Cyan on black
    mov si, titleLine5
    mov di, 1444
    call printString
    
    mov ah, 0x0B
    mov si, titleLine6
    mov di, 1604
    call printString
    
    ; Subtitle - Gray text
    mov ah, 0x07
    mov si, subtitle
    mov di, 1924
    call printString
    
    ; Menu options - Clean, professional look
    mov ah, 0x0E  ; Yellow on black
    mov si, option1
    mov di, 2486
    call printString
    
    mov ah, 0x0E
    mov si, option2
    mov di, 2646
    call printString
    
    mov ah, 0x0E
    mov si, option3
    mov di, 2806
    call printString
    
    ret

drawInstructions:
    call clearScreenBlue
    
    mov si, instTitle
    mov di, 484
    mov ah, 0x0F
    call printString
    
    mov si, instLine1
    mov di, 1124
    mov ah, 0x07
    call printString
    mov si, instLine2
    mov di, 1284
    mov ah, 0x07
    call printString
    mov si, instLine3
    mov di, 1604
    mov ah, 0x08
    call printString
    mov si, instLine4
    mov di, 1764
    mov ah, 0x07
    call printString
    
    mov si, instLine5
    mov di, 2084
    mov ah, 0x0E
    call printString
    
    mov si, instLine6
    mov di, 2404
    mov ah, 0x07
    call printString
    mov si, instLine7
    mov di, 2564
    mov ah, 0x07
    call printString
    mov si, instLine8
    mov di, 2724
    mov ah, 0x07
    call printString
    
    mov si, instBack
    mov di, 3684
    mov ah, 0x0E
    call printString
    ret

initGame:
    mov word [score], 0
    mov byte [lives], 3
    mov byte [ballX], 40
    mov byte [ballY], 15
    mov byte [ballDX], 1
    mov byte [ballDY], 255  ; -1 in byte
    mov byte [paddleX], 35
    mov byte [gameOver], 0
    mov byte [oldBallX], 40
    mov byte [oldBallY], 15
    mov byte [oldPaddleX], 35
    mov byte [ballTimer], 0
    
    ; Initialize bricks
    mov di, bricks
    mov cx, 12
    mov al, 2
initTopRow:
    mov [di], al
    inc di
    loop initTopRow
    
    mov cx, 36
    mov al, 1
initRestRows:
    mov [di], al
    inc di
    loop initRestRows
    ret

drawBorder:
    mov ax, 0xB800
    mov es, ax
    mov di, 160
    mov cx, 80
    mov ax, 0x08C4
topBorder:
    stosw
    loop topBorder
    
    mov di, 3840
    mov cx, 80
bottomBorder:
    stosw
    loop bottomBorder
    
    mov cx, 22
    mov di, 320
sideBorders:
    mov word [es:di], 0x08B3
    mov word [es:di+158], 0x08B3
    add di, 160
    loop sideBorders
    
    ; Corners
    mov word [es:160], 0x08DA
    mov word [es:318], 0x08BF
    mov word [es:3840], 0x08C0
    mov word [es:3998], 0x08D9
    ret

drawBricks:
    mov ax, 0xB800
    mov es, ax
    mov si, bricks
    mov bx, brickColors
    
    mov di, 500
    mov cx, 12
    call drawBrickRow
    
    mov di, 660
    mov cx, 12
    call drawBrickRow
    
    mov di, 820
    mov cx, 12
    call drawBrickRow
    
    mov di, 980
    mov cx, 12
    call drawBrickRow
    ret

drawBrickRow:
    push cx
drawBrickLoop:
    lodsb
    mov ah, [bx]
    inc bx
    cmp al, 0
    je skipBrick
    
    mov al, 0xDB
    mov [es:di], ax
    mov [es:di+2], ax
    mov [es:di+4], ax
    mov [es:di+6], ax
    mov [es:di+8], ax
skipBrick:
    add di, 10
    loop drawBrickLoop
    pop cx
    ret

eraseBrick:
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    
    mov ax, bx
    mov bl, 12
    div bl
    mov dl, al
    mov dh, ah
    
    xor ah, ah
    mov al, dl
    add al, 3
    xor ah, ah
    mov bl, 80
    mul bl
    add ax, 10
    push ax
    
    mov al, dh
    xor ah, ah
    mov bl, 5
    mul bl
    pop bx
    add ax, bx
    shl ax, 1
    mov di, ax
    
    mov ax, 0xB800
    mov es, ax
    mov ax, 0x0020
    mov cx, 5
eraseBrickLoop2:
    stosw
    loop eraseBrickLoop2
    
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret

eraseOldPaddle:
    mov ax, 0xB800
    mov es, ax
    mov di, 3680
    xor ax, ax
    mov al, [oldPaddleX]
    shl ax, 1
    add di, ax
    mov ah, 0x00
    mov al, ' '
    mov cl, [paddleSize]
    xor ch, ch
eraseOldPaddleLoop:
    mov [es:di], ax
    add di, 2
    loop eraseOldPaddleLoop
    ret

drawPaddle:
    call eraseOldPaddle
    mov ax, 0xB800
    mov es, ax
    mov di, 3680
    xor ax, ax
    mov al, [paddleX]
    shl ax, 1
    add di, ax
    mov ah, 0x0E
    mov al, 0xDB
    mov cl, [paddleSize]
    xor ch, ch
drawPaddleLoop:
    mov [es:di], ax
    add di, 2
    loop drawPaddleLoop
    mov al, [paddleX]
    mov [oldPaddleX], al
    ret

eraseOldBall:
    mov ax, 0xB800
    mov es, ax
    xor ax, ax
    mov al, [oldBallY]
    mov bx, 160
    mul bx
    mov di, ax
    xor ax, ax
    mov al, [oldBallX]
    shl ax, 1
    add di, ax
    mov word [es:di], 0x0020
    ret

drawBall:
    call eraseOldBall
    mov ax, 0xB800
    mov es, ax
    xor ax, ax
    mov al, [ballY]
    mov bx, 160
    mul bx
    mov di, ax
    xor ax, ax
    mov al, [ballX]
    shl ax, 1
    add di, ax
    mov ah, 0x0F
    mov al, 'O'
    mov [es:di], ax
    mov al, [ballX]
    mov [oldBallX], al
    mov al, [ballY]
    mov [oldBallY], al
    ret

drawStatus:
    mov ax, 0xB800
    mov es, ax
    
    ; Lives - clean white text
    mov di, 164
    mov si, livesText
    mov ah, 0x0F
    call printString
    
    xor ax, ax
    mov al, [lives]
    call printNumber
    
    ; Score - clean white text
    mov di, 280
    mov si, scoreText
    mov ah, 0x0F
    call printString
    
    mov ax, [score]
    call printNumber
    ret

printNumber:
    push ax
    push bx
    push cx
    push dx
    
    mov bx, 10
    xor cx, cx
convertLoop:
    xor dx, dx
    div bx
    push dx
    inc cx
    test ax, ax
    jnz convertLoop
    
    mov ax, 0xB800
    mov es, ax
printDigits:
    pop ax
    add al, '0'
    mov ah, 0x0F
    stosw
    loop printDigits
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret

checkWin:
    mov si, bricks
    mov cx, 48
checkWinLoop:
    lodsb
    cmp al, 0
    jg notWinYet
    loop checkWinLoop
    mov byte [gameOver], 2
    ret
notWinYet:
    ret

moveBall:
    mov al, [ballDX]
    add [ballX], al
    mov al, [ballDY]
    add [ballY], al
    
    cmp byte [ballX], 2
    jg checkRightWall
    mov byte [ballDX], 1
    mov byte [ballX], 2
    call playWallSound
    call wallBounceEffect
    jmp checkY

checkRightWall:
    cmp byte [ballX], 77
    jl checkY
    mov byte [ballDX], 255  ; -1
    mov byte [ballX], 77
    call playWallSound
    call wallBounceEffect

checkY:
    cmp byte [ballY], 2
    jle reverseDY
    cmp byte [ballY], 23
    je checkPaddle
    cmp byte [ballY], 24
    jge lostLife
    jmp checkBricks

reverseDY:
    neg byte [ballDY]
    call playWallSound
    call wallBounceEffect
    jmp checkBricks

checkPaddle:
    mov al, [ballX]
    mov bl, [paddleX]
    cmp al, bl
    jl checkBricks
    mov cl, bl
    add cl, [paddleSize]
    cmp al, cl
    jge checkBricks
    mov byte [ballDY], 255  ; -1
    call playPaddleSound
    call paddleHitEffect
    
    add bl, 4
    cmp al, bl
    jl paddleHitLeft
    add bl, 2
    cmp al, bl
    jl paddleHitCenter
    mov byte [ballDX], 1
    jmp checkBricks

paddleHitLeft:
    mov byte [ballDX], 255  ; -1
    jmp checkBricks

paddleHitCenter:
    jmp checkBricks

lostLife:
    call playLifeLostSound
    call lifeLostEffect
    dec byte [lives]
    mov byte [ballX], 40
    mov byte [ballY], 15
    mov byte [ballDX], 1
    mov byte [ballDY], 255  ; -1
    mov byte [oldBallX], 40
    mov byte [oldBallY], 15
    cmp byte [lives], 0
    jne checkBricks
    mov byte [gameOver], 1

checkBricks:
    mov al, [ballY]
    cmp al, 3
    jl doneBricks
    cmp al, 7
    jge doneBricks
    
    mov al, [ballY]
    sub al, 3
    mov bl, al
    mov al, [ballX]
    sub al, 10
    js doneBricks
    xor ah, ah
    mov cl, 5
    div cl
    mov bh, al
    cmp bh, 12
    jae doneBricks
    
    mov al, bl
    xor ah, ah
    mov cl, 12
    mul cl
    xor ah, ah
    add al, bh
    xor ah, ah
    mov bx, ax
    
    mov si, bricks
    add si, bx
    cmp byte [si], 0
    je doneBricks
    dec byte [si]
    jnz brickBounce
    
    push bx
    call playBrickSound
    call brickDestroyEffect
    call eraseBrick
    pop bx
    add word [score], 10

brickBounce:
    neg byte [ballDY]

doneBricks:
    ret

playGame:
    call initGame
    call clearScreen
    call drawBorder

gameLoop:
    call drawBricks
    call drawStatus
    call drawPaddle
    call drawBall
    
    cmp byte [gameOver], 0
    jne endGameCheck
    call checkWin

endGameCheck:
    cmp byte [gameOver], 0
    jne showEndScreen
    
    inc byte [ballTimer]
    mov al, [ballThreshold]
    cmp byte [ballTimer], al
    jl skipBallMove
    mov byte [ballTimer], 0
    call moveBall

skipBallMove:
    mov cx, 0x2500
delayLoop:
    loop delayLoop
    
    mov ah, 0x01
    int 0x16
    jz gameLoop
    
    mov ah, 0x00
    int 0x16
    cmp ah, 0x01
    je exitGame
    cmp ah, 0x4B
    je moveLeft
    cmp ah, 0x4D
    je moveRight
    jmp gameLoop

moveLeft:
    cmp byte [paddleX], 2
    jle gameLoop
    dec byte [paddleX]
    dec byte [paddleX]
    jmp gameLoop

moveRight:
    mov al, [paddleX]
    add al, [paddleSize]
    cmp al, 77
    jge gameLoop
    inc byte [paddleX]
    inc byte [paddleX]
    jmp gameLoop

showEndScreen:
    call clearScreen
    
    cmp byte [gameOver], 1
    je showGameOverMsg
    
    call playVictorySound
    call victoryEffect
    mov di, 1600
    mov si, winText
    mov ah, 0x0A
    call printString
    jmp showFinalScore

showGameOverMsg:
    call playGameOverSound
    call gameOverEffect
    mov di, 1600
    mov si, gameOverText
    mov ah, 0x0C
    call printString

showFinalScore:
    mov ax, [score]
    call printNumber
    
    mov di, 1920
    mov si, pressEsc
    mov ah, 0x07
    call printString

waitEndKey:
    mov ah, 0x00
    int 0x16
    cmp ah, 0x01
    jne waitEndKey

exitGame:
    ret

; ===== SOUND EFFECTS =====

; Play sound using PC speaker
; Input: BX = frequency divisor
; Input: CX = duration
playSound:
    push ax
    push bx
    push cx
    
    ; Set up timer 2 for sound
    mov al, 0xB6
    out 0x43, al
    
    ; Set frequency
    mov ax, bx
    out 0x42, al
    mov al, ah
    out 0x42, al
    
    ; Turn on speaker
    in al, 0x61
    or al, 0x03
    out 0x61, al
    
    ; Wait for duration
soundWait:
    push cx
    mov cx, 0x0100
soundInnerLoop:
    loop soundInnerLoop
    pop cx
    loop soundWait
    
    ; Turn off speaker
    in al, 0x61
    and al, 0xFC
    out 0x61, al
    
    pop cx
    pop bx
    pop ax
    ret

; High pitch for brick destruction
playBrickSound:
    push bx
    push cx
    mov bx, 800      ; High frequency
    mov cx, 3        ; Short duration
    call playSound
    pop cx
    pop bx
    ret

; Medium pitch for wall bounce
playWallSound:
    push bx
    push cx
    mov bx, 1200     ; Medium frequency
    mov cx, 2        ; Very short duration
    call playSound
    pop cx
    pop bx
    ret

; Medium-low pitch for paddle hit
playPaddleSound:
    push bx
    push cx
    mov bx, 1500     ; Medium-low frequency
    mov cx, 3        ; Short duration
    call playSound
    pop cx
    pop bx
    ret

; Low pitch for life lost
playLifeLostSound:
    push bx
    push cx
    mov bx, 2000     ; Low frequency
    mov cx, 15       ; Longer duration
    call playSound
    pop cx
    pop bx
    ret

; Victory sound - ascending tones
playVictorySound:
    push bx
    push cx
    
    mov bx, 1500
    mov cx, 5
    call playSound
    
    mov bx, 1200
    mov cx, 5
    call playSound
    
    mov bx, 900
    mov cx, 5
    call playSound
    
    mov bx, 700
    mov cx, 10
    call playSound
    
    pop cx
    pop bx
    ret

; Game over sound - descending tones
playGameOverSound:
    push bx
    push cx
    
    mov bx, 1000
    mov cx, 8
    call playSound
    
    mov bx, 1400
    mov cx, 8
    call playSound
    
    mov bx, 1800
    mov cx, 8
    call playSound
    
    mov bx, 2200
    mov cx, 15
    call playSound
    
    pop cx
    pop bx
    ret

; Visual Effects
wallBounceEffect:
    push ax
    push cx
    push di
    mov ax, 0xB800
    mov es, ax
    mov di, 160
    mov cx, 80
    mov ax, 0x08C4
wallRestoreLoop:
    stosw
    loop wallRestoreLoop
    pop di
    pop cx
    pop ax
    ret

lifeLostEffect:
    push ax
    push bx
    push cx
    push dx
    mov ax, 0xB800
    mov es, ax
    xor di, di
    mov cx, 2000
    mov dx, 0x0420
redFlashLoop:
    mov ax, [es:di]
    and al, 0xFF
    or ah, 0x04
    stosw
    sub di, 2
    loop redFlashLoop
    mov cx, 0x5000
lifeDelayLoop:
    loop lifeDelayLoop
    pop dx
    pop cx
    pop bx
    pop ax
    ret

paddleHitEffect:
    ret

brickDestroyEffect:
    ret

victoryEffect:
    push ax
    push cx
    push di
    mov cx, 3
victoryFlashLoop:
    push cx
    mov ax, 0xB800
    mov es, ax
    xor di, di
    mov cx, 2000
victoryBrightLoop:
    mov ax, [es:di]
    or ah, 0x0F
    stosw
    sub di, 2
    loop victoryBrightLoop
    mov cx, 0x3000
victoryDelay1:
    loop victoryDelay1
    xor di, di
    mov cx, 2000
victoryDimLoop:
    mov ax, [es:di]
    and ah, 0x07
    stosw
    sub di, 2
    loop victoryDimLoop
    mov cx, 0x3000
victoryDelay2:
    loop victoryDelay2
    pop cx
    loop victoryFlashLoop
    pop di
    pop cx
    pop ax
    ret

gameOverEffect:
    push ax
    push cx
    push di
    mov cx, 3
gameOverFadeLoop:
    push cx
    mov ax, 0xB800
    mov es, ax
    xor di, di
    mov cx, 2000
gameOverDarkenLoop:
    mov ax, [es:di]
    and ah, 0x08
    stosw
    sub di, 2
    loop gameOverDarkenLoop
    mov cx, 0x4000
gameOverFadeDelay:
    loop gameOverFadeDelay
    pop cx
    loop gameOverFadeLoop
    pop di
    pop cx
    pop ax
    ret

; ===== DATA SECTION =====

; Clean, professional ASCII art
titleLine1: db '     A T A R I',0
titleLine2: db '  ===============',0
titleLine3: db '     B R E A K O U T',0

titleLine5: db '  B R E A K O U T',0
titleLine6: db '  ---------------',0

subtitle: db '         Classic Arcade Game',0

; Clean menu options
option1: db '             [1] Start Game',0
option2: db '             [2] Instructions',0
option3: db '             [3] Exit',0

instTitle: db '         HOW TO PLAY',0
instLine1: db '  Break all 48 blocks to win',0
instLine2: db '  Top row blocks need TWO hits',0
instLine3: db '  -------------------------------',0
instLine4: db '  You have 3 lives. Good luck!',0
instLine5: db '  CONTROLS:',0
instLine6: db '    Left Arrow  - Move paddle left',0
instLine7: db '    Right Arrow - Move paddle right',0
instLine8: db '    ESC         - Pause/Exit',0
instBack: db '    Press ESC to return',0

livesText: db 'Lives: ',0
scoreText: db 'Score: ',0
gameOverText: db 'GAME OVER - Score: ',0
winText: db 'VICTORY - Score: ',0
pressEsc: db '    Press ESC to continue',0

brickColors:
    db 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C
    db 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06
    db 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E
    db 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A

currentScreen: db 0
score: dw 0
lives: db 3
ballX: db 40
ballY: db 20
ballDX: db 1
ballDY: db 255
paddleX: db 35
paddleSize: db 10
gameOver: db 0
bricks: times 48 db 1
oldBallX: db 40
oldBallY: db 20
oldPaddleX: db 35
ballTimer: db 0
ballThreshold: db 24