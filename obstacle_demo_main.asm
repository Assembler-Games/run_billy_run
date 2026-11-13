# Group 4 - Billy Run player code
# File: render.asm
# Contributors: 
# Last Modified: 11/07/2026
# Purpose: 
.include "macros.asm"
.data
continue: .word 1 #variable use to check if continue
exitMsg: .asciiz "Exiting game...Have a great day!\n"

.text

.globl main

main: 
	
	#initialize billy
	jal initBilly
	jal initObstacle
	

	# Draw Billy
	jal drawBilly
	
	# Draw Ground
	jal drawGround
gameLoop:
	
	# Erase billy from the bitmap display by drawing black pixel at his position	
	jal eraseBilly
	
	# Check keyboard input for SPACE key
	jal checkKeyboard
	
	# calculate and update billy's position if billy is jumping
	jal updateBillyPhysics
	
	# draw billy
	jal updateObstacle
	jal drawBilly
	
	# delay between frames 
	li $v0, 32
	li $a0, 50
	syscall
	
	li $t0, 0
	lw $t1, continue
	beq $t0, $t1, exit
	
	j gameLoop

exit:
	li $v0, 10
	syscall


# This are placed at the bottom because
.include "billy.asm"
.include "keyboard_input.asm"
.include "render.asm"


.include "obstacle.asm"
