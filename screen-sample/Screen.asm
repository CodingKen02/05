// File name: projects/IO_ASM/screen/Screen.asm

// Selects SCREEN (16384) and creates a variable
// based on the starting location of the screen
// NOTE: This is not necessary. I do it for consistency.
@SCREEN
D=A
@screenStart
M=D

// Selects KBD (24576) and creates a variable
// based on the ending location of the screen
// NOTE: End of screen is 1 register before the KBD.
@KBD
D=A-1
@screenEnd
M=D

// Selects the constant value which aligns with 
// the register representing the middle of the 
// screen.
@20479
D=A 
@screenMid
M=D

// Simply initialize the current location.
@currentLoc

// Code used to detect keyboard input from user
// 
// Case ('F'):
//     Fill entire screen
// Case ('T'):
//     Fill top half of screen
// Case ('B'):
//     Fill bottom half of screen
// Case (default):
//     Clear screen
(CHECK_KEYBOARD)
    // Checks if 'F' is pressed
    // Jumps to FILL_INIT if so
    @KBD 
    D=M 
    @70 // 'F'
    D=D-A 
    @FILL_INIT 
    D;JEQ

    // Checks if 'T' is pressed
    // Jumps to T_INIT if so
    @KBD 
    D=M 
    @84 // 'T'
    D=D-A 
    @TOP_INIT
    D;JEQ

    // Checks if 'B' is pressed
    // Jumps to BOTTOM_INIT if so
    @KBD 
    D=M 
    @66 // 'B'
    D=D-A 
    @BOTTOM_INIT
    D;JEQ

    // Jumps to CLEAR_INIT if none
    // of the prior cases are met
    @CLEAR_INIT
    0;JMP

// Sets our current location at
// the beginning of the screen
(FILL_INIT)
    @screenStart
    D=M 
    @currentLoc
    M=D

// Beginning of FILL loop
(FILL)
    // Sets our current location in memory 
    // based on our location variable
    // NOTE: This is pointer notation
    @currentLoc
    A=M
    M=-1 // fills the entire register

    // Checks if our current location is
    // at the end of the screen. Jumps to
    // CHECK_KEYBOARD if so
    @currentLoc
    D=M
    @screenEnd
    D=M-D
    @CHECK_KEYBOARD
    D;JLE

    // Increments our current location
    // in the screen and restarts the 
    // FILL loop
	@currentLoc
	M=M+1
	@FILL
	0;JMP

// Sets our current location at
// the middle of the screen
(TOP_INIT)
    @screenMid
    D=M 
    @currentLoc
    M=D
    
// Beginning of TOP loop
(TOP)
    // Sets our current location in memory 
    // based on our location variable
    // NOTE: This is pointer notation
    @currentLoc
    A=M
    M=-1 // fills the entire register

    // Checks if our current location is
    // at the start of the screen. Jumps to
    // CHECK_KEYBOARD if so
    @currentLoc
    D=M
    @screenStart
    D=D-M
    @CHECK_KEYBOARD
    D;JLE

    // Decrements our current location
    // in the screen and restarts the 
    // TOP loop
	@currentLoc
	M=M-1
	@TOP
	0;JMP

// Sets our current location at
// the middle of the screen
(BOTTOM_INIT)
    @screenMid
    D=M 
    @currentLoc
    M=D+1
    
// Beginning of BOTTOM loop
(BOTTOM)
    // Sets our current location in memory 
    // based on our location variable
    // NOTE: This is pointer notation
    @currentLoc
    A=M
    M=-1 // fills the entire register

    // Checks if our current location is
    // at the end of the screen. Jumps to
    // CHECK_KEYBOARD if so
    @currentLoc
    D=M
    @screenEnd
    D=M-D
    @CHECK_KEYBOARD
    D;JLE

    // Increments our current location
    // in the screen and restarts the 
    // TOP loop
    @currentLoc
    M=M+1
    @BOTTOM
    0;JMP

// Sets our current location at
// the start of the screen
(CLEAR_INIT)
    @screenStart
    D=M 
    @currentLoc
    M=D
    
// Beginning of CLEAR loop
(CLEAR)
    @currentLoc
    A=M
    M=0 // clears the entire register

    // Checks if our current location is
    // at the end of the screen. Jumps to
    // CHECK_KEYBOARD if so
    @currentLoc
    D=M
    @screenEnd
    D=M-D
    @CHECK_KEYBOARD
    D;JLE

    // Increments our current location
    // in the screen and restarts the 
    // CLEAR loop
    @currentLoc
    M=M+1
    @CLEAR
    0;JMP
    