// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
    @8192 // address from 0 -> 16383 = RAM16K chip; initializing the "max" build and 0 as a value
    D=A
    @max
    M=D
    @0
    D=A
    @i
    M=D
(CHECK_KEYBOARD) // as well as an infinite loop; checking if a key is being pressed or not
    @KBD // address 24576 = Keyboard chip
    D=M
    @CLEAR
    D;JEQ
(FILL) // fill the screen if a key is pressed
    @max
    D=M
    @i
    D=D-M
    @CHECK_KEYBOARD
    D;JLE
    @i
    D=M
    @SCREEN // address from 16384 -> 24575 = Screen chip
    A=A+D
    M=-1
    @i
    D=M
    D=D+1
    @i
    M=D
    @CHECK_KEYBOARD
    0;JMP // jump back
(CLEAR) // clear the screen if no key is pressed
    @i
    D=M
    @SCREEN
    A=A+D
    M=0
    @i
    D=M
    @CHECK_KEYBOARD 
    D;JLE
    D=D-1
    @i
    M=D
    @CHECK_KEYBOARD
    0;JMP // jump back