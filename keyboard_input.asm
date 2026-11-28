#===========================================
# Group 4 - Billy Run player code
# File: keyboard_input.asm
# Contributors: 
# Last Modified: 11/07/2026
# Purpose: Handle keyboard input from user via MMIO
#===========================================

.data
message: .asciiz "Press SPACE to jump!\n"
jumpMsg: .asciiz "Jump detected!\n"

.text

#===========================================
# Function: checkKeyboard()
# Purpose: Checks the MMIO Control Receiver's ready bit and SPACE input.
# Input: none
#===========================================
checkKeyboard:
	
	li $t0, 0xFFFF0000 # Set $t0 to point to MMIO Receiver Control addres
	lw $t1, 0($t0) # Load the word stored in MMIO RC
	andi $t1, $t1, 1 # Perform bitwise and operations
	
	beq $t1, $zero, keyboardDone

	lw $t2, 4($t0) # Load the word in the MMIO Data Receiver address: 0xFFFF0004	
	
checkForKey_Space:	
	# Check if the input is the SPACE value (ASCII value 32 decimal)
	li $t3, 32 # load immediate value of 32 for comparison
	beq $t2, $t3, setBillyJumping # branch to keyboardDone if the input was not SPACE

checkForKey_q:
	# Check if the input is the q value (ASCII value 113 Decimal)
	li $t3, 113
	beq $t2, $t3, setToExitGame
	
					
keyboardDone:
	# Return to caller
	jr $ra

#===========================================
# Function: setBillyJumping()
# Purpose: Sets the values of Billy's velocity, gracity, and set billyJumping to TRUE
# Input: none
#===========================================
setBillyJumping:
	# Set register $t0 to point to variable address holding JUMP_VELOCITY
	li $t0, JUMP_VELOCITY
	sw $t0, billyYVel # update Billy's Y velocity to -5 pixes/frame
	
	# Set isBillyJumping = 1 (yes)
	li $t0, 1
	sw $t0, isBillyJumping
	
	# Play jump sound
	li $v0, 31 	# play sound
	li $a0, 65 	# pitch value
	li $a1, 80 	# duration
	li $a2, 81  # instrument
	li $a3, 100 # volume
	syscall
	
	j keyboardDone


setToExitGame:
	li $t0, 0
	sw $t0, continue
