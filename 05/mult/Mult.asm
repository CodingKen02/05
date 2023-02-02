// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.

// Put your code here.
    @R0 // stores x in R0
    D=M
    @x
    M=D
    @R1 // stores y in R1
    D=M
    @y
    M=D
    @0 // initiating 0 as starting value; stored in R2
    D=A
    @R2
    M=D
(LOOP) // looping R0
    @x
    D=M
    @END
    D;JLE // if x <= 0, goto END
    @y
    D=M // D = y
    @2
    M=D+M // sum = sum + y
    @1
    D=A // D = 1
    @x
    M=M-D // x = x - 1
    @LOOP
    0;JMP // jump to loop
(END)
    @END
    0;JMP // infinite loop